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
		./gen-shell-script.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [

			sqlite

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
      easyeffects
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

      # vpn
      wireguard-tools

      # yazi
      mediainfo
      trash-cli
      dragon-drop

      # browsers
      chrome
      brave

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
      spotify
      discord
      whatsapp-electron
      zsh
      btop
      wget
      eza
      heroic-unwrapped
      networkmanagerapplet
			loupe

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

      # absolute goat best editor to this day
      neovim

    ])
    ++ (with pkgs-very-unstable; [

			google-lighthouse

      # lsp szpont
			htmx-lsp2
      typescript-language-server
      bash-language-server
      clang-tools
      superhtml
      vscode-css-languageserver
      nixd
      hyprls
      pyright
      rust-analyzer
      intelephense
      markdown-oxide
      jdt-language-server
      nodejs
      typescript
      lua-language-server
      gnumake
      zig
      ripgrep
      gopls

      # formatting
      shfmt
      stylua
      rustfmt
      black
      prettierd
      php85Packages.php-codesniffer
      google-java-format
      nixfmt

      # szpont pro max ++++
      gemini-cli


      # terminal
      ghostty
      alacritty
      kitty

      lorien

			zenity
			air

    ]);

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
