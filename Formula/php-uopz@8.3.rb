class PhpUopzAT83 < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz@8.3-7.1.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7f45f51cdf8b8380ffa54a1a1db2374bfbe87dd1d7e0f2420428e6284c562d85"
    sha256 cellar: :any,                 arm64_linux:  "1643740bbdfdb714b922b5456b886705d8a50511dba16d293ab3fc64d042648d"
    sha256 cellar: :any,                 x86_64_linux: "ecb0ac6968d36c06e46d4b709f339ee5d189cf6ad8d7b617402f74780fb37150"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php@8.3")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "uopz-#{version}" unless build.head?
    system Formula["php@8.3"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uopz.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/ext-uopz.ini"
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
    assert_match "uopz", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
