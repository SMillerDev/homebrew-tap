class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v3.3.1.tar.gz"
  sha256 "abf7f734d3e60f9422c66c59e750c5a2a112687980f0107ec41e7f6706e76185"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.3.1"
    sha256 cellar: :any,                 monterey:     "326bdc5653c7dd6401cdf7c60de95c0a0edd58da0d35ed8957fd4044831a9627"
    sha256 cellar: :any,                 big_sur:      "bfcb5528a1003cdbdaf981d64e3a2465d42a112601106bc651c2a5e5554043ab"
    sha256 cellar: :any,                 catalina:     "da73cd2a3c0e53e23aaa32701dba7cb01a253cda805da2f97d190992f26b62bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9928bca5f05cc1eca0fc6ded00305ef41a93287e3f539ef23a016543d0f5fb07"
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
