{ ... }:

{
  # powerManagement = {
  #   enable = true;
  #   powertop.enable = true;
  # };

  powerManagement.enable = true;

  services = {
    # system76-scheduler.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;

    thermald.enable = true;

    power-profiles-daemon.enable = false;

    tlp = {
      enable = true;
      settings = {
        USB_AUTOSUSPEND = 1;
        WIFI_PWR_ON_BAT = "on";
        RUNTIME_PM_ON_BAT = "auto";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced"; # balanced, performance, low-power

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;
      };
    };
  };

}
