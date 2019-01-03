class PhpImagick < Formula
  desc "Imagick Extension for PHP"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"

  depends_on "autoconf" => :build
  depends_on "php"
  depends_on "pkg-config" => :build
  depends_on "imagemagick" =>

  def module_path
    extension_dir = Utils.popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "imagick-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-imagick=#{Formula["imagemagick"].prefix}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/imagick.so"
  end

    def post_install
    ext_config_path = etc/"php"/Formula["php"].php_version/"conf.d"/"ext-imagick.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/imagick.so\""
    else
      ext_config_path.write <<~EOS
        [imagick]
        extension=\"#{opt_lib/module_path}/imagick.so\"
      EOS
    end
  end

  test do
    assert_match "imagick", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
