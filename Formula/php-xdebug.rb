class PhpXdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-3.1.2.tgz"
  sha256 "083f6be1100df79ccbdf049dafc3930bab35f0eb80f9b19ac1ad84fa6779ccf3"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-xdebug-3.1.1_1"
    sha256 big_sur:      "c620da57241edb27426205fece617bf38faec7a12eef3447a27fb2c21491d7cc"
    sha256 catalina:     "38d35077ecdeb161348d30700068eec761ee4b3be2db63cb80840a5063b4b5e7"
    sha256 x86_64_linux: "2e6922855d184d3b9877fd62aa5652e34825a60b82d9e255b4aa5b365b9fddd2"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
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
