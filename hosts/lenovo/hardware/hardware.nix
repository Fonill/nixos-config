{ pkgs, config, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false; 
    };

    graphics = {
      enable = true;
      enable32Bit = true;
			extraPackages = with pkgs; [
				vpl-gpu-rt # Intel VPL
				vulkan-loader
				vulkan-validation-layers
				vulkan-extension-layer
			];
    };

    nvidia = {
      modesetting.enable = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement = {
        enable = true; 
        finegrained = true; 
      };

      open = true;
      nvidiaSettings = false;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

}
