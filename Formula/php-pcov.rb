class PhpPcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-pcov-1.0.6"
    sha256 cellar: :any_skip_relocation, catalina:     "7bf01a239eb86fd6f5ea262aa40e29dc8905fad451857b2887c8d0f9e0842492"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "95e2d17d139f4b5debe97cfa32d13f7523d4a5364e0372c9fc6946e591d57363"
  end

  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --enable-pcov
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/pcov.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-pcov.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/pcov.so\""
    else
      ext_config_path.write <<~EOS
        [pcov]
        extension=\"#{opt_lib/module_path}/pcov.so\"
      EOS
    end
  end

  test do
    assert_match "pcov", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
