class PhpAutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/0.1.1a.tar.gz"
  sha256 "6e182613e17ba275f2cb31be4e86656b74c38b6500d0521a8dbfdb88a261feec"

  depends_on "autoconf" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
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
    ext_config_path = etc/"php"/Formula["php"].php_version/"conf.d"/"ext-autoload_psr.ini"
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
