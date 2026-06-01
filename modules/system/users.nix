{ pkgs, ... }:

{
  users = {
    users.fonil = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Fonil";
      extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    };

  };
}
