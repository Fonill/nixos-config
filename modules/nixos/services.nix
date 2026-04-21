{ pkgs, ... }:

{
  services = {
    blueman.enable = true;
    displayManager.gdm.enable = true;

    udev.packages = [ pkgs.headsetcontrol ];

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    tailscale.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;

      extraConfig.pipewire = {
        context.properties = {
          default.clock.rate = 96000;
          defautlt.allowed-rates = [ 96000 48000 44100 ];
          # defautlt.allowed-rates = [ 96000  ];
        };
      };
    };

    udisks2.enable = true;

  };

  security.rtkit.enable = true;
}
