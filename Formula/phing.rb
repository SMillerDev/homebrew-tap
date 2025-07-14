class Phing < Formula
  desc "Not GNU make"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-3.0.0.phar"
  sha256 "00306c4024295943a619260a41f1acf926ce220daac960bd1a52f4e83f3f9ddf"
  head "https://github.com/phingofficial/phing.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phing-3.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cb837412c6a46e33423c8b3461e80ee795964be8da824913c74cf6507361c663"
    sha256 cellar: :any_skip_relocation, ventura:       "835711608e2618ab5c3a281d91415e9bc446e7568d5c16b3e77deedb0cb387db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56734f63555dee408cfbea4b1399ea69b7440acb8a5d9b7b885855c83375eecc"
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
