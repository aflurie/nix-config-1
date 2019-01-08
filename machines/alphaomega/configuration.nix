{ config, pkgs, ... }:

{
  imports =[
    <nixos-hardware/lenovo/thinkpad/t480s>
    <nixos-hardware/common/cpu/intel/kaby-lake>
    ./environment.nix
    ./hardware-configuration.nix
    ./programs
    ./services
    ./system.nix
  ];

  boot.earlyVconsoleSetup = true;

  networking.hostId = "c0bebeef";
  networking.hostName = "alphaomega";
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreeRedistributable = true;
  };

  nixpkgs.overlays =
    let path = ../../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                      (attrNames (readDir path)));


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     emacsToolsEnv
     gitToolsEnv
     javaToolsEnv
     jsToolsEnv
     langToolsEnv
     networkingToolsEnv
     nixToolsEnv
     nixUtilitiesEnv
     nixosAppsEnv
     gcloudToolsEnv
     goToolsEnv
     pythonToolsEnv
     scalaToolsEnv
     systemToolsEnv
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      # dpi = 144;
      antialias = true;
      hinting.enable = true;
    };
    fonts = with pkgs; [
      font-awesome-ttf
      hack-font
      helvetica-neue-lt-std
      unifont
   ];
  };

  documentation.dev.enable = true;

  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = false;

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  powerManagement.powertop.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  virtualisation.virtualbox.host.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ptsirakidis = {
     isNormalUser = true;
     uid = 1000;
     description = "Periklis Tsirakidis";
     extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
     shell = "/run/current-system/sw/bin/zsh";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
