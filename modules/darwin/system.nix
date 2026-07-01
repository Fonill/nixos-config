{ ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
		#	XDG_CONFIG_HOME = "~/.config";
    };

    shellAliases = {
      tree = "eza -T";
      nix-shell = "nix-shell --command $SHELL ";
      nd = "nix develop -c $SHELL";
      ls = "eza --icons";
      n = "nvim";
      nvim = "nvim";
      cy = "cd ~/studia; yazi";
      cs = "cd ~/studia";

      ncfg = "nvim ~/nix-config/hosts/nixbook/configuration.nix";
      kcfg = "nvim ~/.config/kitty/kitty.conf";

      reb = "sudo darwin-rebuild switch --flake ~/nix-config#nixbook";

      calen = "calcurse";
      cal = "cal -n 12";
      ghgrab = "nix run github:abhixdd/ghgrab";
      gpu = "git pull";
			ga = "git add";
			gc = "git commit";
			gp = "git push";
			gd = "git diff";
    };
  };

  system.stateVersion = 5;
}
