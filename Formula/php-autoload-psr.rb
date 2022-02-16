class PhpAutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/0.2.0.tar.gz"
  sha256 "9d4fa71854231851079ffc62ff30c2cda7c823f44e51d81b578db64065739af0"
  head "https://github.com/pprkut/autoload-psr.git"

  # disable! date: "2021-03-01", because: "support pending"

  depends_on "autoconf" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php"].bin/"phpize"
    system "./configure", "--with-php-config=#{Formula["php"].opt_bin/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-autoload_psr.ini"
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
    assert_match "autoload_psr", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
