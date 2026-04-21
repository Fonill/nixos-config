{
  pkgs,
  pkgs-very-unstable,
  nurpkgs,
  ...
}:

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


      ngrok
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
      nurpkgs.repos.lonerOrz.helium
      google-chrome
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

      # cloc # tool to count lines of code
      # valgrind # tool to debug programs

    ])
    ++ (with pkgs-very-unstable; [

      # absolute goat best editor to this day
      neovim

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
      air

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

			# cli to gui
      zenity

    ]);

  programs = {
    zoxide.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    chromium = {
      enable = true;

      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # Dark Reader
        "dbepggeogbaibhgnhhndojpepiihcmeb;https://clients2.google.com/service/update2/crx" # Vimium
        "blipmdconlkpinefehnmjammfjpmpbjk;https://clients2.google.com/service/update2/crx" # Lighthouse
        "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx" # Bitwarden
        "nkphlkgkhmdaecflflapohlkkchmcacc;https://clients2.google.com/service/update2/crx" # Save for later
        "mnjggcdmjocbbbhaepdhchncahnbgone;https://clients2.google.com/service/update2/crx" # SponsorBlock
        "oldceeleldhonbafppcapldpdifcinji;https://clients2.google.com/service/update2/crx" # AI Grammar checker
        "gebbhagfogifgggkldgodflihgfeippi;https://clients2.google.com/service/update2/crx" # Dislikes

      ];
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
          name = "Fonill";
          email = "macieksobczak11@gmail.com";
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
