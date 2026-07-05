{ pkgs, ... }:

{
  imports = [
    ./system.nix
    ./zsh.nix
    ./custom
  ];

  nix.settings.experimental-features = "nix-command flakes";
  # documentation.doc.enable = false;
  documentation.enable = false;

  system = {
    stateVersion = 5;
    primaryUser = "fonil";
  };

  nixpkgs = {
    config = {

      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

    hostPlatform = "aarch64-darwin";

  };

  homebrew = {
    enable = true;
    casks = [
      "figma"
      "firefox"
      "google-chrome"
      "steam"
      "obs"
      "discord"
      "spotify"
      "blender"
      "whatsapp"
      "gimp"
      "krita"
      "prismlauncher"
      "signal"
      "veracrypt"
      "zed"
    ];
  };

  environment.systemPackages = with pkgs; [
    zoxide
    luarocks
    tree-sitter

    starship
    kitty
    neovim
    obsidian
    vimPlugins.nvim-treesitter.withAllGrammars
    raycast
    yazi

    git
    tree
    btop
    wget
    eza
    fastfetch
    trash-cli
    p7zip
    poppler-utils
    mediainfo
    ffmpeg
    libqalculate
    cmatrix
    speedtest-cli
    opencode
    dragon-drop
    ripgrep

    hashcat
    hashcat-utils
    ghidra

		ngrok
    gcc
    go
    python3
    nodejs
    typescript
    gnumake
    zig
    lldb

    live-server
    htmx-lsp2
    typescript-language-server
    bash-language-server
    clang-tools
    superhtml
    vscode-css-languageserver
    nixd
    pyright
    rust-analyzer
    intelephense
    markdown-oxide
    jdt-language-server
    lua-language-server
    gopls
    air
    shfmt
    stylua
    rustfmt
    black
    prettierd
    php85Packages.php-codesniffer
    google-java-format
    nixfmt

    direnv

    # lorien
  ];
}
