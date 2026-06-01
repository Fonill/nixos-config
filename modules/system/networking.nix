{ ... }:

{
  networking = {
    hostName = "nixos";

		firewall = {
			# allowedUDPPorts = [ 51820 ];
		};

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    nameservers = [
      "45.90.28.0#lapek-a7ff13.dns.nextdns.io"
      "45.90.30.0#lapek-a7ff13.dns.nextdns.io"
    ];

  #   wg-quick.interfaces.protonvpn = {
  #     autostart = false;
  #     dns = [ "systemd-resolved" ];
  #     listenPort = 51820;
  #     privateKey = "";
  #     address = [ "10.2.0.2/32" ];
  #     peers = [
  #       {
  #         publicKey = "g0gQj1lhsEuyJcJlzVyjq7aQmtC+/ca05vqOqvCQ/zI=";
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         endpoint = "146.70.230.130:51820";
  #       }
  #     ];
  #   };

  };

  services.resolved = {
    enable = true;
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [ "" ];
    llmnr = "false";
  };

}
