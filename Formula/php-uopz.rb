class PhpUopz < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz-7.1.0_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "c98adb88ea4850c187f2bd2e5e99a71eb09c2076209efee0e4c0f6439eac998f"
    sha256 cellar: :any_skip_relocation, catalina:     "677a7d2dc8af80c67d95af5a00385582e574bd926b15512597ba7ab95f97b8ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "17683e00ed5bea71a934990cf42585ae10691300d842cd6c4d059c6b0a038aa7"
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
