class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v3.2.2.tar.gz"
  sha256 "99038ff766db7939f753de72d651de424900f7911f2e7b6107f9decfce832808"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.2.1"
    sha256 cellar: :any,                 big_sur:      "e73cd676c21b50ae310a5b8044f6bb385e82203aa54eec214ee90db9195ccabf"
    sha256 cellar: :any,                 catalina:     "b99b985e2aee98d776c716daab9775ed5f6dc1c4caf6723ddd14de613dc400ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "34da04ddd537859f7369c6e9b601118744b1179dc5b0d51a9c3813d1e6065991"
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
