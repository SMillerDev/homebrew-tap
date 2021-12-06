class TeleportAT7 < Formula
  desc "Modern SSH server for teams managing distributed infrastructure"
  homepage "https://gravitational.com/teleport"
  url "https://github.com/gravitational/teleport/archive/v7.3.6.tar.gz"
  sha256 "2cdb9135feeca03a401195aae0873f16a4dd2ab0a03f10ac257ec7909eaecaf1"
  license "Apache-2.0"
  head "https://github.com/gravitational/teleport.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/teleport@7-7.3.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "75db290e13cc6fa608d586ab9f0b0cf809685fe3402779b69c6d15a8f75952be"
    sha256 cellar: :any_skip_relocation, catalina:     "b67fe74ac39e69e5a428347a0ae9b4bebc564f60e8b10a3e679159a2dff02381"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "80b4fc8a698ebe885cf61b8774ab885584e4fb9aff9106d0cf5f96b28fd5a019"
  end

  # This version will live as long as I'm affected by https://github.com/gravitational/teleport/issues/9028
  deprecate! date: "2021-11-17", because: :versioned_formula

  depends_on "go" => :build

  uses_from_macos "curl" => :test
  uses_from_macos "netcat" => :test
  uses_from_macos "zip"

  # Keep this in sync with https://github.com/gravitational/teleport/tree/v#{version}
  resource "webassets" do
    url "https://github.com/gravitational/webassets/archive/07493a5e78677de448b0e35bd72bf1dc6498b5ea.tar.gz"
    sha256 "2074ee7e50720f20ff1b4da923434c05f6e1664e13694adde9522bf9ab09e0fd"
  end

  def install
    (buildpath/"webassets").install resource("webassets")
    ENV.deparallelize { system "make", "full" }
    bin.install Dir["build/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/teleport version")
    (testpath/"config.yml").write shell_output("#{bin}/teleport configure")
      .gsub("0.0.0.0", "127.0.0.1")
      .gsub("/var/lib/teleport", testpath)
      .gsub("/var/run", testpath)
      .gsub(/https_(.*)/, "")

    fork do
      exec "#{bin}/teleport start -c #{testpath}/config.yml --debug"
    end

    sleep 10
    system "curl", "--insecure", "https://localhost:3080"
    system "nc", "-z", "localhost", "3022"
    system "nc", "-z", "localhost", "3023"
    system "nc", "-z", "localhost", "3025"
  end
end
