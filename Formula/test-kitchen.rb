class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v2.11.1.tar.gz"
  sha256 "5bf08e95c2cc31bcf7d533767210846d3df51855714062663b4d92ea1caf433e"
  head "https://github.com/test-kitchen/test-kitchen.git"

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
