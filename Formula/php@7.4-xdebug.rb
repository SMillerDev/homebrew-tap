class PhpAT74Xdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-3.1.2.tgz"
  sha256 "083f6be1100df79ccbdf049dafc3930bab35f0eb80f9b19ac1ad84fa6779ccf3"
  head "https://github.com/xdebug/xdebug.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-xdebug-3.1.2"
    sha256 big_sur:      "b939b05c64bbb32bdf77407bb04c9d3fb0a3c7c038e159166e8a679fc8e505e2"
    sha256 catalina:     "23beaeb14a56f3c5c171ff491a10a08a7a7a68013ab58578f6959cfebd349b8b"
    sha256 x86_64_linux: "591c664723e76715f350c5f3056bac9e63f87dc851e984ad3a3b2b55e01b66e9"
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
