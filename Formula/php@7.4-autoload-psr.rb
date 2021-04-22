class PhpAT74AutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/0.1.2.tar.gz"
  sha256 "edee4c0fb8d66238509e080697a868ad454444242ffb269cb52c6cceabd04c2c"
  head "https://github.com/pprkut/autoload-psr.git"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-autoload-psr-0.1.2"
    sha256 cellar: :any_skip_relocation, catalina:     "8a523bd5672c1d2027f9fc34eaffecdceb629a1796bccfc3b3f6b1bcd605c0c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3217db38bf50ad45b26ab212b11547eef8d95be6fd85e1563b11cbf0d0bfb613"
  end

  depends_on "autoconf" => :build
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php@7.4"].bin/"phpize"
    system "./configure", "--with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-autoload_psr.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/autoload_psr.so\""
    else
      ext_config_path.write <<~EOS
        [autoload_psr]
        extension=\"#{opt_lib/module_path}/autoload_psr.so\"
      EOS
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
