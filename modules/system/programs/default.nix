{ pkgs, pkgs-very-unstable, ... }:
let
  chrome = pkgs.google-chrome.override {
    commandLineArgs = [
      "--disable-features=WaylandWpColorManagerV1"
    ];
  };

  brave = pkgs.brave.override {
    commandLineArgs = [
      "--disable-features=WaylandWpColorManagerV1"
    ];
  };
in
{
  imports = [
    ./zsh.nix
    ./yazi
    ./starship.nix
    ./java.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
		mpv

    vivify

    figma-linux
    filezilla

    gcc
		go

    # audio
    vlc
    headsetcontrol

    # equalizers
    # easyeffects
    jamesdsp

    libresprite
    blockbench
    handbrake

    gparted
    wineWowPackages.wayland

    # nvim live server
    live-server

    # treesitterszpont
    vimPlugins.nvim-treesitter.withAllGrammars

		# debugger
		lldb

    # lsp szpont
		pkgs-very-unstable.nodePackages.typescript-language-server
    pkgs-very-unstable.bash-language-server
    pkgs-very-unstable.clang-tools
    pkgs-very-unstable.superhtml
    pkgs-very-unstable.vscode-css-languageserver
    pkgs-very-unstable.nixd
    pkgs-very-unstable.hyprls
    pkgs-very-unstable.pyright
    pkgs-very-unstable.rust-analyzer
    pkgs-very-unstable.intelephense
    pkgs-very-unstable.markdown-oxide
    pkgs-very-unstable.jdt-language-server
    pkgs-very-unstable.nodePackages.nodejs
    pkgs-very-unstable.nodePackages.typescript
    pkgs-very-unstable.lua-language-server
    pkgs-very-unstable.gnumake
    pkgs-very-unstable.zig
    pkgs-very-unstable.ripgrep
    pkgs-very-unstable.gopls

    # formating
		pkgs-very-unstable.shfmt
    pkgs-very-unstable.stylua
    pkgs-very-unstable.rustfmt
    pkgs-very-unstable.black
    pkgs-very-unstable.prettierd
    pkgs-very-unstable.php85Packages.php-codesniffer
    pkgs-very-unstable.google-java-format
    pkgs-very-unstable.nixfmt

    # vpn
    wireguard-tools

    # yazi
    mediainfo
    trash-cli
    dragon-drop

    # browsers
    chrome
    brave
    vivaldi

    # calendar
    calcurse

    # szpont++
    veracrypt
    hashcat
    hashcat-utils
    ghidra
    cmatrix
    speedtest-cli
    opencode

    # signal
    signal-desktop

    # szpont pro max +++
    screenfetch
    fastfetch
    nerdfetch

		# szpont pro max ++++
		pkgs-very-unstable.gemini-cli

    # better msoffice (no epstein island here)
    libreoffice-qt6-fresh

    # bluetooth type shit
    bluez

    # hyprshit
    hyprpaper
    hyprsunset
    hyprlock
    hyprshade
    hyprcursor
    hyprshot
    waybar
		quickshell
    wofi
    stow
    brightnessctl

    # absolute goat best editor to this day
    pkgs-very-unstable.neovim

    # clipboard
    clipse
    wl-clipboard

    # apps
    obsidian
    # kdePackages.dolphin
    bitwarden-desktop
    feh
    libqalculate
    p7zip
    gimp
    krita
    blender
    obs-studio
    ffmpeg
    lorien
		pkgs-very-unstable.ghostty
		pkgs-very-unstable.alacritty
    pkgs-very-unstable.kitty
    spotify
    discord
    zsh
    btop
    wget
    eza
    heroic-unwrapped
		networkmanagerapplet

    steam
		ckan

    # nix shell shit
    direnv
    nix-direnv

    # minecraft
    prismlauncher
    gradle

    # abolute shitshow
    # cloc
    # teams-for-linux
    # valgrind
    # adwaita-icon-theme

  ];


  programs = {
    zoxide.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
      policies = {
        DisableTelemetry = true;
      };
    };

    git = {
      enable = true;
      config = {
        user = {
          name = "Linofff";
          email = "rowerman2137@gmail.com";
        };
        init.defaultBranch = "main";
        core.sshCommand = "ssh -i ~/.ssh/github";
      };
    };

    ssh = {
      startAgent = true;
      extraConfig = "AddKeysToAgent yes";
    };

  };
}
