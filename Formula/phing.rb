class Phing < Formula
  desc "Not GNU make"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.17.0.phar"
  sha256 "1703462b5c3ab7841c760cbae6a4a7f3cfda2acd715fd34b663ab13f2ac96546"
  head "https://github.com/phingofficial/phing.git"

  depends_on "php" => :test

  def install
    bin.install "phing-#{version}.phar" => "phing"
  end

  test do
    (testpath/"build.xml").write <<~EOS
      <project name="HomebrewTest" default="init" basedir=".">
        <property name="build" value="build"/>
        <target name="init">
          <mkdir dir="${build}"/>
        </target>
        <target name="move" depends="init">
          <copy file="myfile.txt" tofile="${build}/mycopy.txt"/>
        </target>
      </project>
    EOS
    (testpath/"myfile.txt").write <<~EOS
      Hello World
    EOS
    system "#{bin}/phing", "move"
    assert_predicate testpath/"myfile.txt", :exist?
    assert_predicate testpath/"build/mycopy.txt", :exist?
  end
end
