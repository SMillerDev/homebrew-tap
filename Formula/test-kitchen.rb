class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/refs/tags/v3.6.0.tar.gz"
  sha256 "220766c3c51745dd72e3f3c3cd8c108ab05e00d792692976acef958726c72c51"
  head "https://github.com/test-kitchen/test-kitchen.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/test-kitchen-3.6.0"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma: "b62cb1ba0b5fde9f48eb089a98008bf41f4835357686fb09fae38826b4a0653e"
    sha256 cellar: :any,                 ventura:      "1fec42c377ea65c8978bcc76ef8ffb31ef9ba0aded11ddba7eb0028c2f0c8eb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "13e6925e04f5c4a27e4f992065d2bade092eba31c44d8cd68121b474c92d1d8f"
  end

  depends_on "pkg-config" => :build
  depends_on "ruby"

  uses_from_macos "libffi", since: :catalina

  def install
    ENV["GEM_HOME"] = libexec
    ENV["BUNDLE_PATH"] = libexec

    system "gem", "install", "bundler"
    ENV.prepend_path "PATH", buildpath/"gem_home/bin"
    system "bundle", "install", "--jobs=#{ENV.make_jobs}"

    system "gem", "install", "rexml", "--norc", "--no-document"
    system "gem", "install", "kitchen-inspec", "--norc", "--no-document"
    system "gem", "install", "kitchen-salt", "--norc", "--no-document"
    system "gem", "install", "kitchen-vagrant", "--norc", "--no-document"
    system "gem", "install", "kitchen-docker", "--norc", "--no-document"
    system "gem", "install", "kitchen-dokken", "--norc", "--no-document"

    if OS.mac?
      ext_path = "extensions/#{Hardware::CPU.arch}-darwin-*/*/ffi-*/mkmf.log"
      rm_r Dir[libexec/ext_path.to_s, libexec/"ruby/*/#{ext_path}"]
    end

    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
    (bin/"kitchen").write_env_script(libexec/"bin/kitchen", GEM_PATH: libexec)
  end

  test do
    system "#{bin}/kitchen", "init"
    assert_path_exists testpath/"kitchen.yml"
    assert_path_exists testpath/"chefignore"
    assert_path_exists testpath/"test/integration/default"
  end
end
