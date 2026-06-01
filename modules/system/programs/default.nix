{ pkgs, ... }:
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
  ];

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [

		vimPlugins.nvim-treesitter.withAllGrammars

		# lsp szpont
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
		nodePackages.nodejs nodePackages.typescript
		lua-language-server
		gnumake
		zig
		ripgrep

		# formating
		stylua
		rustfmt
		black
		prettierd
    php85Packages.php-codesniffer
		google-java-format
		nixfmt

		# vpn
		wireguard-tools

    # yazi
    mediainfo
    trash-cli
    dragon-drop

    # browsers
    chrome brave firefox vivaldi

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
    wofi
    stow
    brightnessctl

    # absolute goat best editor to this day
    neovim

    # clipboard
    clipse
    wl-clipboard

    # apps
    obsidian
    kdePackages.dolphin
    bitwarden-desktop
    feh
    libqalculate
    p7zip
    gimp
    krita
    blender
    # jetbrains.idea
    obs-studio
    ffmpeg
    lorien
    kitty
    spotify
    discord
    vesktop
    zsh
    btop
    wget
    eza
    steam

    # nix shell shit
    direnv
    nix-direnv

    # games
    prismlauncher

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

  };
}
