class PhpAT74AutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/0.2.0.tar.gz"
  sha256 "9d4fa71854231851079ffc62ff30c2cda7c823f44e51d81b578db64065739af0"
  head "https://github.com/pprkut/autoload-psr.git"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-autoload-psr-0.2.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ce8c1a1d50b25e981d25c5a6b6af6e36358c365c887671cc59f50d1528edb625"
    sha256 cellar: :any_skip_relocation, catalina:     "7b4b24ddfc8ea58d4178d36a0ee38f4d4840603abedddf7c873460f0dd5b3e88"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fdc797e5fe4e4f7042a4b6e72929c0dee8a517016d6e32360f549c6135d8fe76"
  end

  depends_on "autoconf" => :build
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
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
        extension="#{opt_lib/module_path}/autoload_psr.so"
      EOS
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
