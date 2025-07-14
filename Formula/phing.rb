class Phing < Formula
  desc "Not GNU make"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.17.0.phar"
  sha256 "1703462b5c3ab7841c760cbae6a4a7f3cfda2acd715fd34b663ab13f2ac96546"
  head "https://github.com/phingofficial/phing.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phing-2.17.0"
    sha256 cellar: :any_skip_relocation, catalina:     "4cf6f16d64a12ac6e19ca580a0b0687ebf4fe16e6045a3f3e7c5c5e13d99daf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c134c51d43e0b70d040025d473d07d166249a199f73e66eeee3ff87c19a07689"
  end

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
    assert_path_exists testpath/"myfile.txt"
    assert_path_exists testpath/"build/mycopy.txt"
  end
end
