{ ... }:

{
  services = {
    blueman.enable = true;
    displayManager.gdm.enable = true;
    printing.enable = true;

		tailscale.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
    };

    udisks2.enable = true;

  };

  security.rtkit.enable = true;
}
