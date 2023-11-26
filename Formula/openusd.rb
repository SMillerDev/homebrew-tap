class Openusd < Formula
  desc "System for authoring, reading, and streaming time-sampled scene description"
  homepage "https://openusd.org/release/index.html"
  url "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v23.05.tar.gz"
  sha256 "f5c3e72cd584bab383a8054628b6ed98aa17b1cbbe896eb98257ac19641d10c7"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "python@3.11" => :build
  depends_on "alembic"
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "embree"
  depends_on "openexr"
  depends_on "openimageio"
  depends_on "opensubdiv"
  depends_on "tbb"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
                                              "-DBoost_NO_BOOST_CMAKE=OFF",
                                              "-DPXR_BUILD_ALEMBIC_PLUGIN=TRUE",
                                              "-DPXR_BUILD_OPENIMAGEIO_PLUGIN=TRUE",
                                              "-DPXR_ENABLE_PYTHON_SUPPORT=FALSE"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
