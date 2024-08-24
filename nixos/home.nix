{ config, pkgs, ... }:

{
  home.username = "dalu";
  home.homeDirectory = "/home/dalu";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i2/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  home.file.".vimrc".source = ./vimrc;

  ## Cursor size and font DPI.
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    fd
    gnumake
    xclip

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    neofetch
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # Fonts.
    lxgw-wenkai
    (nerdfonts.override { fonts = [ "ComicShannsMono" ]; })

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    neovim
    neovide

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  #programs.emacs = {
  #  enable = true;
  #  package = pkgs-unstable.emacs;
  #};

  #programs.neovide = {
  #  enable = true;
  #  package = pkgs-unstable.neovide;
  #};

  programs.git = {
    enable = true;
    userName = "Mou Tong";
    userEmail = "mou.tong@outlook.com";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 16.0;
        normal.family = "ComicShannsMono Nerd Font";
        #normal.family = "LXGW WenKai Mono";
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window = {
        dimensions = {
          columns = 160;
          lines = 40;
        };
      };
    };
  };

  # programs.tmux = {
  #   enable = true;
  #   shortcut = "a";
  # };

  programs.zellij.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -alh";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      bindkey -e

      # Insert sudo before command.
      sudo_command_line() {
          [[ -z $BUFFER ]] && zle up-history
          [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
          zle end-of-line
      }
      
      zle -N sudo_command_line
      bindkey '\e\e' sudo_command_line
    '';
  };

  programs.zoxide.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
