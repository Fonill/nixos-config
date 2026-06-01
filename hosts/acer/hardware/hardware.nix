{ ... }:

{

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "modesetting" ];
  };

}
