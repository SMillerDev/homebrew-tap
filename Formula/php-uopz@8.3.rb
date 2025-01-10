class PhpUopzAT83 < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz-7.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "3f5482506c3d7936256aac25e8e09e3bba922f9f1465a69753b9b5409ecaacda"
    sha256 cellar: :any_skip_relocation, catalina:     "d7abad1fc95b91147c63cce9b94bbb907d503b044cae0dbf77e5245bbb298a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "708f8e8fe776f1031fb1bda84bdb91fda85056d61c829a939baf7131c0f7a8f8"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@8.3"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "uopz-#{version}" unless build.head?
    system Formula["php@8.3"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@8.3"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uopz.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@8.3"].version.major_minor/"conf.d"/"ext-uopz.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/uopz.so\""
    else
      ext_config_path.write <<~EOS
        [uopz]
        extension="#{opt_lib/module_path}/uopz.so"
      EOS
    end
  end

  test do
    assert_match "uopz", shell_output("#{Formula["php@8.3"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
