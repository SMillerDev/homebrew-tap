class PhpAT74Raphf < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-raphf-2.0.1"
    sha256 cellar: :any_skip_relocation, catalina:     "d67d356443523b294cefb8f25fbebbf59060d9c5b391e52f1f6f84097ecbec92"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "06c304173d3515dede6e5fcfa892279fd953efa666283db4ad308d2534596190"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "raphf-#{version}"
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"raphf@7.4"
    (include/"raphf@7.4").install %w[php_raphf.h src/php_raphf_api.h]
    (lib/module_path).install "modules/raphf.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-raphf.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/raphf.so\""
    else
      ext_config_path.write <<~EOS
        [raphf]
        extension=\"#{opt_lib/module_path}/raphf.so\"
      EOS
    end
  end

  test do
    assert_match "raphf", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
