# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest_t480;

  boot.initrd.kernelModules = [ "i915" ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [
    "acpi_call"
    "kvm-intel"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];

  boot.kernelParams = [
    "snd_hda_intel.power_save=1"
    "i915.enable_dc=2"
    "i915.enable_guc=2"
    "i915.enable_psr=1"
    "i915.enable_dpcd_backlight=1"
    "bbswitch.load_state=0"
    "bbswitch.unload_state=1"
  ];

  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.laptop_mode" = 5;
  };

  boot.initrd.luks.devices.zroot = {
    device = "/dev/disk/by-uuid/270c62c0-70d4-44a0-8a3b-50ce8941b61a";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
      zfsSupport = true;
      efiInstallAsRemovable = false;
    };
  };

  fileSystems."/" =
    { device = "zroot/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7CAE-6141";
      fsType = "vfat";
    };

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.nvidiaOptimus.disable = true;
  
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    linuxPackages.nvidia_x11.out
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    linuxPackages.nvidia_x11.lib32
  ];
 
  hardware.enableAllFirmware = true;

  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  hardware.trackpoint.enable = lib.mkDefault true;

  nix.maxJobs = lib.mkDefault 8;
  
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference - - - - balance_power"
  ];

  swapDevices = [ { device = "/dev/nvme0n1p2"; } ];
}
