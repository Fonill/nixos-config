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

			prime = {
				offload.enable = true;

				intelBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:1:0:0";
			};
    };

    opentabletdriver.enable = true;
    uinput.enable = true;
  };

	services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

}
