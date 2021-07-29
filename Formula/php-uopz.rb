class PhpUopz < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.0.0.tgz"
  sha256 "955de7e28f74fb83033bfb29fa5c1350400ea894bbec5cda79f63563ef6ae775"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz-7.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "d1a589d5e75e697c9400e9f70b9ee8054f3d8acc22180384db91cfc29d9fc07c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "675f91037bd4e2c9d406a450cd04617ebc7d59067d913b8462becc582e071879"
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
    cd "uopz-#{version}" unless build.head?
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uopz.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-uopz.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/uopz.so\""
    else
      ext_config_path.write <<~EOS
        [uopz]
        extension=\"#{opt_lib/module_path}/uopz.so\"
      EOS
    end
  end

  test do
    assert_match "uopz", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
