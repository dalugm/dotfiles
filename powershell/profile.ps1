# Basic.
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
