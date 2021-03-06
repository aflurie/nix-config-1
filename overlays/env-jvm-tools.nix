self: super:
{
  javaToolsEnv = super.buildEnv {
    name = "javaTools";
    paths = [
      self.ant
      self.maven
      self.jmeter
      self.openjdk
    ];
  };

  scalaToolsEnv = super.buildEnv {
    name = "scalaTools";
    paths = [
      self.sbt
      self.scala
    ];
  };
}
