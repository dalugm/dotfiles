$env:SHELL = "pwsh.exe"

Set-PSReadLineOption -EditMode Emacs

function Get-FileSize {
  Get-ChildItem | ForEach-Object {
    $size = $_.Length;
    $sizeString = switch ($size) {
      {$_ -ge 1MB} { "{0:N2} MB" -f ($_ / 1MB); break }
      {$_ -ge 1KB} { "{0:N2} KB" -f ($_ / 1KB); break }
      default { "$_ Bytes" }
    }

    [PSCustomObject]@{
      Name = $_.Name;
      Size = $sizeString
    };
  } | Format-Table -AutoSize
}

Set-Alias -Name ll -Value Get-FileSize

## Zoxide

# =============================================================================
#
# Utility functions for zoxide
#

# Call zoxide binary, returning the output as UTF-8
function global:__zoxide_bin {
    $encoding = [Console]::OutputEncoding
    try {
        [Console]::OutputEncoding = [System.Text.Utf8Encoding]::new()
        $result = zoxide @args
        return $result
    } finally {
        [Console]::OutputEncoding = $encoding
    }
}

# pwd based on zoxide's format
function global:__zoxide_pwd {
    $cwd = Get-Location
    if ($cwd.Provider.Name -eq "FileSystem") {
        $cwd.ProviderPath
    }
}

# cd + custom logic based on the value of _ZO_ECHO
function global:__zoxide_cd($dir, $literal) {
    $dir = if ($literal) {
        Set-Location -LiteralPath $dir -Passthru -ErrorAction Stop
    } else {
        if ($dir -eq '-' -and ($PSVersionTable.PSVersion -lt 6.1)) {
            Write-Error "cd - is not supported below PowerShell 6.1. Please upgrade your version of
PowerShell."
        }
        elseif ($dir -eq '+' -and ($PSVersionTable.PSVersion -lt 6.2)) {
            Write-Error "cd + is not supported below PowerShell 6.2. Please upgrade your version of
PowerShell."
        }
        else {
            Set-Location -Path $dir -Passthru -ErrorAction Stop
        }
    }
}

# =============================================================================
#
# Hook configuration for zoxide
#

# Hook to add new entries to the database
$global:__zoxide_oldpwd = __zoxide_pwd
function global:__zoxide_hook {
    $result = __zoxide_pwd
    if ($result -ne $global:__zoxide_oldpwd) {
        if ($null -ne $result) {
            zoxide add "--" $result
        }
        $global:__zoxide_oldpwd = $result
    }
}

# Initialize hook
$global:__zoxide_hooked = (Get-Variable __zoxide_hooked -ErrorAction SilentlyContinue -ValueOnly)
if ($global:__zoxide_hooked -ne 1) {
    $global:__zoxide_hooked = 1
    $global:__zoxide_prompt_old = $function:prompt

    function global:prompt {
        if ($null -ne $__zoxide_prompt_old) {
            & $__zoxide_prompt_old
        }
        $null = __zoxide_hook
    }
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function global:__zoxide_z {
    if ($args.Length -eq 0) {
        __zoxide_cd ~ $true
    }
    elseif ($args.Length -eq 1 -and ($args[0] -eq '-' -or $args[0] -eq '+')) {
        __zoxide_cd $args[0] $false
    }
    elseif ($args.Length -eq 1 -and (Test-Path $args[0] -PathType Container)) {
        __zoxide_cd $args[0] $true
    }
    else {
        $result = __zoxide_pwd
        if ($null -ne $result) {
            $result = __zoxide_bin query --exclude $result "--" @args
        }
        else {
            $result = __zoxide_bin query "--" @args
        }
        if ($LASTEXITCODE -eq 0) {
            __zoxide_cd $result $true
        }
    }
}

# Jump to a directory using interactive search.
function global:__zoxide_zi {
    $result = __zoxide_bin query -i "--" @args
    if ($LASTEXITCODE -eq 0) {
        __zoxide_cd $result $true
    }
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd
#

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# =============================================================================
#
# To initialize zoxide, add this to your configuration (find it by running
# `echo $profile` in PowerShell):
#
Invoke-Expression (& { (zoxide init powershell | Out-String) })

## Fzf

$env:FZF_DEFAULT_OPTS=@"
--preview 'bat {}'
--bind ctrl-a:preview-top
--bind ctrl-e:preview-bottom
--bind ctrl-f:preview-page-down
--bind ctrl-b:preview-page-up
--bind ctrl-d:preview-half-page-down
--bind ctrl-u:preview-half-page-up
--bind ctrl-j:preview-down
--bind ctrl-k:preview-up
--bind ctrl-g:toggle-preview
"@

## proxy

function proxy_on {
    param(
        [int]$SocksPort = 10808,
        [int]$HttpPort = 10809
    )

    $warn = 0

    # Check SOCKS port (SOCKS uses TCP as well)
    $socksListening = Get-NetTCPConnection -LocalPort $SocksPort -State Listen -ErrorAction SilentlyContinue
    if (-not $socksListening) {
        Write-Host "Warning: SOCKS port $SocksPort does not seem to have a listening service" -ForegroundColor Yellow
        $warn = 1
    }

    # Check HTTP port
    $httpListening = Get-NetTCPConnection -LocalPort $HttpPort -State Listen -ErrorAction SilentlyContinue
    if (-not $httpListening) {
        Write-Host "Warning: HTTP port $HttpPort does not seem to have a listening service" -ForegroundColor Yellow
        $warn = 1
    }

    if ($warn -eq 1) {
        Write-Host "Proxy may not work correctly. Please check your proxy service." -ForegroundColor Yellow
    }

    $env:HTTP_PROXY = "http://127.0.0.1:$HttpPort"
    $env:HTTPS_PROXY = "http://127.0.0.1:$HttpPort"
    $env:ALL_PROXY = "socks5://127.0.0.1:$SocksPort"
    $env:NO_PROXY = "localhost,127.0.0.1,::1"

    Write-Host "Proxy enabled (SOCKS: $SocksPort, HTTP: $HttpPort)" -ForegroundColor Green
}

function proxy_off {
    Remove-Item -Path Env:HTTP_PROXY, Env:HTTPS_PROXY, Env:ALL_PROXY, Env:NO_PROXY -ErrorAction SilentlyContinue
    Write-Host "Proxy disabled" -ForegroundColor Yellow
}

function proxy_status {
    $http = if ($env:HTTP_PROXY) { $env:HTTP_PROXY } else { "<not set>" }
    $https = if ($env:HTTPS_PROXY) { $env:HTTPS_PROXY } else { "<not set>" }
    $all = if ($env:ALL_PROXY) { $env:ALL_PROXY } else { "<not set>" }
    $no = if ($env:NO_PROXY) { $env:NO_PROXY } else { "<not set>" }

    Write-Host "HTTP_PROXY  = $http"
    Write-Host "HTTPS_PROXY = $https"
    Write-Host "ALL_PROXY   = $all"
    Write-Host "NO_PROXY    = $no"
}

## _
# Local Variables:
# outline-regexp: "##+"
# End:
