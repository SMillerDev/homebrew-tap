class Phing < Formula
  desc "Not GNU make"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.16.1.phar"
  sha256 "dcc7b63e1a1f8e1599b0fb33a02b053ee9adcdd2885538e36d7e1f5c81062040"
  head "https://github.com/phingofficial/phing.git"

  bottle :unneeded

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
