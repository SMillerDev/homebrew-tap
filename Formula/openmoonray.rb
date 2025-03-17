class Openmoonray < Formula
  desc "DreamWorks’ production MCRT renderer"
  homepage "https://openmoonray.org"
  url "https://github.com/dreamworksanimation/openmoonray.git",
      tag:      "v1.2.0.0",
      revision: "a212d261df2f9b198baf40c96fc53f6a87c56414"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "cppunit"
  depends_on "jsoncpp"
  depends_on "libmicrohttpd"
  depends_on "openimageio"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_QT_APPS=NO"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
