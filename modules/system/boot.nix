{ ... }:

{
  boot = {
    kernelModules = ["uinput"];
  
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

  };
}
