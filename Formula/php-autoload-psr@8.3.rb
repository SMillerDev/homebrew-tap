class PhpAutoloadPsrAT83 < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr@8.3-0.2.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "359bae6eb997854fe193045f113a49af1b53c2c1e4691196a6c97e58b27109dc"
    sha256 cellar: :any,                 arm64_linux:  "3f1421ce64e6c5ea34d5d4a140cb3fb641c8e0ff08bbbdea8e4d7eaa51972ccf"
    sha256 cellar: :any,                 x86_64_linux: "1adb685c57786b9a21507653a25c70964f5c48f82809f38f716511705e37e7ea"
  end

  depends_on "autoconf" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php@8.3")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php@8.3"].bin/"phpize"
    system "./configure", "--with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/ext-autoload_psr.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/autoload_psr.so\""
    else
      ext_config_path.write <<~EOS
        [autoload_psr]
        extension="#{opt_lib/module_path}/autoload_psr.so"
      EOS
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
