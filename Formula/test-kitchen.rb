class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v3.1.0.tar.gz"
  sha256 "03b27ceb2e3d063db0f891914e05d8721dc160efe1e2bb607f463d93eff7d76a"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.0.0"
    sha256 cellar: :any,                 catalina:     "4c2d3f21444bcd44ccb158d545076663b1867f1e5ce4b7bb1465f162cce0385a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d939fee093426abbc3f82c1f8e18536e56a8d7c69233a5d7ee1c6310b462293b"
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
