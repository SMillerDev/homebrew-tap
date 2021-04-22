class PhpAT74Xdebug < Formula
  desc "XDebug Extension for PHP"
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-3.0.4.tgz"
  sha256 "b27290491f4634b0cd3badfc3a2be98fb1e3c0c3710a706724d8b195baad72af"
  head "https://github.com/xdebug/xdebug.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-xdebug-3.0.4"
    sha256 catalina:     "2cca10d49fc549e8a918ae7d9ace2a7e83b26beb45a20577a4f34b57c7982c7d"
    sha256 x86_64_linux: "2e11f464606654e7ac609178d129593e55d1a9f5f5b02bc00c44eb55e8cb2c58"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin/"php-config"} --extension-dir").chomp
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
