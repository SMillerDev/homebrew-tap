class PhpXdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://pecl.php.net/xdebug"
  url "https://xdebug.org/files/xdebug-3.0.2.tgz"
  sha256 "096d46dec061341868d3e3933b977013a592e2e88992b2c0aba7fa52f87c4e17"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-xdebug-3.0.2"
    sha256 "5ef3930b238f22b963911aceb705962e1f3d93a544f98cc998f2926f5395f982" => :catalina
    sha256 "b10947a6e5b2fad94f8b28a488e7f0c4a4d15f48e3c3cfc4eec0bcad4841a126" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "xdebug-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/xdebug.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-xdebug.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /zend_extension=.*$/, "zend_extension=\"#{opt_lib/module_path}/xdebug.so\""
    else
      ext_config_path.write <<~EOS
        [xdebug]
        zend_extension=\"#{opt_lib/module_path}/xdebug.so\"
      EOS
    end
  end

  test do
    assert_match "xdebug", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
