self: super:
{
  nixosAppsEnv = super.buildEnv {
    name = "nixosApps";
    paths = [
      self.adobeReader
      self.arandr
      self.brightnessctl
      self.firefox
      self.google-chrome-dev
      self.handbrake
      self.i3lock-fancy
      self.i3status-rust
      self.jetbrains.idea-ultimate
      self.mupdf
      self.openfortivpn
      self.pavucontrol
      self.skype
      self.slack
      self.vlc
      self.zoom-us
    ];
 };
}
