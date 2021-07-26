class PhpImagick < Formula
  desc "Imagick Extension for PHP"
  homepage "https://pecl.php.net/imagick"
  url "https://pecl.php.net/get/imagick-3.5.1.tgz"
  sha256 "243ff2094edcacb2ae46ee3a4d9f38a60a4f26a6a71f59023b6198cbed0f7f81"
  head "https://github.com/Imagick/imagick.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-imagick-3.5.0"
    sha256                               catalina:     "fd9fc3482951177f45fe1a07b6de20d18e8c885da03e363e49a51c81dd084f09"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dbb1f210e693120b398138b3b5ef6adf659c7189b8e0c35f53fd515173897c80"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "imagemagick"
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
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
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-imagick.ini"
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
