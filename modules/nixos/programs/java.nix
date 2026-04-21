{ pkgs, ... }:

# very necessary to make another file for this
{
  programs.java.enable = true;

	# tool to build java projects
	environment.systemPackages = with pkgs; [
		gradle
	];

}
