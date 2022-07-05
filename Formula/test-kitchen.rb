class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v3.3.1.tar.gz"
  sha256 "abf7f734d3e60f9422c66c59e750c5a2a112687980f0107ec41e7f6706e76185"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.3.0"
    sha256 cellar: :any,                 monterey:     "79b2f01e5c14e7100897865752781e928e2ddeb0c0bb17f48605ee87a36576f2"
    sha256 cellar: :any,                 big_sur:      "38591816a1efc3dc03205bac60dddb4c21719c96b1ef0318c3ca7f492c8e4972"
    sha256 cellar: :any,                 catalina:     "e1fb202fd05e6c8754b37ce153f984baede0cc505c04d92d0200e641b9f2b9fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a5924c2f3e0e060974f0c0808d02c55f4b03e19ba2d3f2ce015c04d36db1081"
  end

  depends_on "pkg-config" => :build
  depends_on "ruby@2.7"

  uses_from_macos "libffi", since: :catalina

  def install
    ENV["GEM_HOME"] = libexec
    ENV["BUNDLE_PATH"] = libexec

    system "gem", "install", "bundler"
    ENV.prepend_path "PATH", buildpath/"gem_home/bin"
    system "bundle", "install", "--jobs=#{ENV.make_jobs}"

    system "gem", "install", "kitchen-inspec", "--norc", "--no-document"
    system "gem", "install", "kitchen-salt", "--norc", "--no-document"
    system "gem", "install", "kitchen-vagrant", "--norc", "--no-document"
    system "gem", "install", "kitchen-docker", "--norc", "--no-document"

    if OS.mac?
      ext_path = "extensions/#{Hardware::CPU.arch}-darwin-*/*/ffi-*/mkmf.log"
      rm_f Dir[libexec/ext_path.to_s, libexec/"ruby/*/#{ext_path}"]
    end

    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
    (bin/"kitchen").write_env_script(libexec/"bin/kitchen", GEM_PATH: libexec)
  end

  test do
    system "#{bin}/kitchen", "init"
    assert_predicate testpath/"kitchen.yml", :exist?
    assert_predicate testpath/"chefignore", :exist?
    assert_predicate testpath/"test/integration/default", :exist?
  end
end
