{ ... }:

{

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "modesetting" ];
  };

}
