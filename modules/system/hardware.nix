{ ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = true;
      nvidiaSettings = false;
    };

    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
  };


}
