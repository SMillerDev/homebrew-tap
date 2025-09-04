class PhpUopzAT83 < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz@8.3-7.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2621a59be55059f1a7db15152a7db7ef378bd0238d3969c31cf9ce513feae2cc"
    sha256 cellar: :any_skip_relocation, ventura:      "ea1c1eedca1de0d9f71faee07681c26f73c45a536546642265830a60e6ac2d60"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41694fc3aba0a69c10d824f4a9a6eee023b020fcba2440ecf4c399630f90e5a4"
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
    assert_match "uopz", shell_output("#{Formula["php@8.3"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
