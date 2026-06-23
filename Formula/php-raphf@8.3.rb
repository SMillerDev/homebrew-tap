class PhpRaphfAT83 < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf@8.3-2.0.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6e1751f1c4e3741b16ba4001cd83fa6b3677fdfe3593babf910e46e8fd39725c"
    sha256 cellar: :any,                 arm64_linux:  "a41219392f475a8828f92795b24a4b2ce177bf65aa0912c6f94564ad90f3f903"
    sha256 cellar: :any,                 x86_64_linux: "d222263935a6571cd57ba3f5107bdb63ff540e69da31f38b291da69af8f98e61"
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
    cd "raphf-#{version}"
    system Formula["php@8.3"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"raphf"
    (include/"raphf").install %w[php_raphf.h src/php_raphf_api.h]
    (lib/module_path).install "modules/raphf.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/10-ext-raphf.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/raphf.so\""
    else
      ext_config_path.write <<~EOS
        [raphf]
        extension="#{opt_lib/module_path}/raphf.so"
      EOS
    end
  end

  test do
    assert_match "raphf", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
