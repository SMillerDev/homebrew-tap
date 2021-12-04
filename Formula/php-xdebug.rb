class PhpXdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-3.1.2.tgz"
  sha256 "083f6be1100df79ccbdf049dafc3930bab35f0eb80f9b19ac1ad84fa6779ccf3"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-xdebug-3.1.2"
    sha256 big_sur:      "33f4339fabe7762194c45a2dd33bad90a24d555bca7df39f4215157cd1162576"
    sha256 catalina:     "0cdd51b455914ef44dc84a327dfac39a89cc7402da1e0bb1895f5242927a8eac"
    sha256 x86_64_linux: "1d1750e37f9b66c82b2233f982f811a8aed9a73c1e9bba828e52f45ae1ff1f18"
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
