{ ... }:

{
  nix = {

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    shellAliases = {
      nix-shell = "nix-shell --command $SHELL ";
      nd = "nix develop -c $SHELL";
      ls="eza --icons";
      v="nixCats";
      n="nvim";
      l="nixCats";
      nvim="nvim";
      lvim="nixCats";
      cy="cd ~/studia; yazi";
      cs="cd ~/studia";
      ncfg="nvim /etc/nixos/modules/system/programs/default.nix";
      kcfg="nvim ~/.config/kitty/kitty.conf";
      nixorg="firefox https://search.nixos.org/packages";
      pogoda="curl wttr.in/Gdansk"; #:)
      reb="sudo nixos-rebuild switch";
      con="rclone mount Fonil:studia ~/cloud --vfs-cache-mode full &";
      discon="fusermount -u ~/cloud";
      calen="calcurse";
      cal="cal -n 12";
    };
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  console.keyMap = "pl2";
  system.stateVersion = "25.05";

}
