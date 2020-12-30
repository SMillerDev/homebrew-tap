class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v2.9.0.tar.gz"
  sha256 "eaf9fd1c16a483a5802f7da4e4852758ce58da214cbc92d4dd49cf01635551f9"
  head "https://github.com/test-kitchen/test-kitchen.git"

  uses_from_macos "ruby", since: :sierra

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
