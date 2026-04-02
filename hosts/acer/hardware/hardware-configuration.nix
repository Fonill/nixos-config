{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-d8bdfba9-1c0e-4e62-86b2-ebc83eac942e";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-d8bdfba9-1c0e-4e62-86b2-ebc83eac942e".device =
    "/dev/disk/by-uuid/d8bdfba9-1c0e-4e62-86b2-ebc83eac942e";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/83D6-4E2C";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
