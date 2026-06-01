{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		histSize = 5000;
		histFile = "$HOME/.zsh_history";

		ohMyZsh = {
			enable = true;

			plugins = [
				"git"
				"z"
			];
		};

		promptInit = /* bash */''

      # Source the Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Enable instant prompt (if desired)
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Source your custom config (e.g., ~/.p10k.zsh)
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
		'';

		shellInit = /* bash */''
			function y() {
				local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
				yazi "$@" --cwd-file="$tmp"
				IFS= read -r -d $'\0' cwd < "$tmp"
				[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
				rm -f -- "$tmp"
			}
		'';

		interactiveShellInit = /* bash */''
			source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      eval "$(direnv hook zsh)"

		'';

	};
}
