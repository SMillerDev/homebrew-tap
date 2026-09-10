class PhpUopzAT83 < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz@8.3-7.1.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "039e17169b1e2ae7f100833d8ca386c1715ffefc44d68aa1e6c5ddfd3e1af558"
    sha256 cellar: :any,                 arm64_linux:  "13dc0d0c5a82b82e55477837a3ba30c25065833f63bd03feedf5e3354d2a3af5"
    sha256 cellar: :any,                 x86_64_linux: "305709fa28288be221440bca6fff2115afd0116cbf02e9047759f46c1bba6d16"
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
    (pkgetc/"ext-uopz.ini").write <<~EOS
      [uopz]
      extension="#{opt_lib/module_path}/uopz.so"
    EOS
  end

  post_install_steps do
    unless_path_exists "php/8.3/conf.d/ext-uopz.ini", base: :etc do
      copy "ext-uopz.ini", "php/8.3/conf.d/ext-uopz.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "uopz", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
