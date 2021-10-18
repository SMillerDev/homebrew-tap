class PhpAT74Xdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-3.1.1.tgz"
  sha256 "9be3ae0fdb4dc4a4c68084626cddc56f12396487e309a8c8dd318f0f900d1a68"
  head "https://github.com/xdebug/xdebug.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-xdebug-3.1.0"
    sha256 catalina:     "0c0004d23bbd9f1089aab27e40b8b6a91feced922c5ac4f2649e2f0f421380a6"
    sha256 x86_64_linux: "c77c480670135cba94ac090a707d77b4c13212a0ccfc6129734b559ec24ffed8"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "xdebug-#{version}"
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/xdebug.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-xdebug.ini"
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
    assert_match "xdebug", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
