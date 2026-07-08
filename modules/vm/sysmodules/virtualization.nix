{ pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;

      daemon.settings = {
        experimental = true;
        default-address-pools = [
          {
            base = "172.30.0.0/16";
            size = 24;
          }
        ];
      };
    };

    libvirtd = {
      enable = true;

      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;

        runAsRoot = false;

        verbatimConfig = ''
          s = []
          user = "+fonil"
        '';

        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
      };
    };

    # spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  boot = {
    initrd.kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_iommu_type1"
    ];
    kernelParams = [
      "iommu=pt"
      "kvm.ignore_msrs=1"
    ];
  };

  users.users.fonil.extraGroups = [
    "libvirtd"
    "qemu-libvirtd"
  ];
}
