class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v3.1.1.tar.gz"
  sha256 "05b64dbd1ab3b2abe1bc6d2d83437496ec412c4b38322de8ec71dcb3fdd5f961"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.1.0"
    sha256 cellar: :any,                 catalina:     "e93956639d15897810b6d6a6db8166630dd55e5cf9a712bb7ed722ef0fa5ce7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a262b731f312183cc551610e5873f1dac3f705db2e535f34760464f2fd263341"
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
