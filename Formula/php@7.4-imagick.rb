class PhpAT74Imagick < Formula
  desc "Imagick Extension for PHP"
  homepage "https://pecl.php.net/imagick"
  url "https://pecl.php.net/get/imagick-3.5.0.tgz"
  sha256 "795db7c36fbacd3d33a4f53ff2d38584c846e80a04dcd04c55e9e46c28f5d229"
  head "https://github.com/Imagick/imagick.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-imagick-3.5.0"
    sha256                               catalina:     "d4ce75cbc668e7e27df858909baf209786e9dc278760178dee2c384869d01f6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5277c617cc133dc9150f70443757e7a40a35b027f68e070b1b73726e8739a738"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "imagemagick"
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "imagick-#{version}"
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
      --with-imagick=#{Formula["imagemagick"].prefix}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/imagick.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-imagick.ini"
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
    assert_match "imagick", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
