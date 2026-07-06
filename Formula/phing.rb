class Phing < Formula
  desc "Not GNU make"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-3.1.2.phar"
  sha256 "75d1e6908dadcd8ed04d1612ce8422ad3b5c69e40cb61299b59e568d90660e44"
  head "https://github.com/phingofficial/phing.git", branch: "main"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phing-3.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2bba0ef772b12b96cd545a8dbc3906d0fca253859184f6fc8b5cd8ac4000661c"
    sha256 cellar: :any_skip_relocation, tahoe:        "92d357259c965a0a8117807ca66a88a0237d5c5d4ba510918003c37cd10ea522"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a16c1dfbc97dc23a4b0603ec5e5ecb326044323c1233b8bbcaac796ae24ac91b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3775c56e574b45e58f82e6f4f06cfd5c51d8a5aa288025e915662abc09a29aec"
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
