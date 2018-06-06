self: super:
{
  goToolsEnv = super.buildEnv {
    name = "goTools";
    paths = [
      self.glide
      self.go
      self.go2nix
    ];
    extraOutputsToInstall = [ "man" "doc" ];
  };
}