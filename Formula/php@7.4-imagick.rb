class PhpAT74Imagick < Formula
  desc "Imagick Extension for PHP"
  homepage "https://pecl.php.net/imagick"
  url "https://pecl.php.net/get/imagick-3.4.4.tgz"
  sha256 "8dd5aa16465c218651fc8993e1faecd982e6a597870fd4b937e9ece02d567077"
  head "https://github.com/Imagick/imagick.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-imagick-3.4.4"
    sha256                               catalina:     "d3f91863f66f3200d7c804574f83c514f33462a9c9cec7ee98567e34be02bb19"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bad4b664dcd3621165e8de144c7d98e7a4f4525f4918ca1aa9d858fdb744d78e"
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
