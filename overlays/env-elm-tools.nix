self: super:
{
  elmToolsEnv = super.buildEnv {
    name = "elmTools";
    paths = [
      self.elmPackages.elm
    ];
  };
}
