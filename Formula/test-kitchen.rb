class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v2.11.2.tar.gz"
  sha256 "ff6602aca73e4a00287186464045775bbb18e604e7afef892fef685538a69b3b"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-2.11.1"
    sha256 cellar: :any,                 catalina:     "7364f38e082280974690c5497aeaec203655ea46fc04748c88682b91b0ee94cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cad9e1dc174bae7bda10b61426cdaf7320131f012f6bc19d32470dea72476d66"
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

    on_macos do
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
