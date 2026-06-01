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
