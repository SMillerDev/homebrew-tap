class PhpPcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.10.tar.gz"
  sha256 "1fd2748f2db4dbbf5f6ac1691b6bd528d23522e0fcdeeda63cbb9de2a0e8d445"
  revision 1
  head "https://github.com/krakjoe/pcov.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-pcov-1.0.10_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "99b305022ea5efb5c055f9a50fda308ff27e61efeb0641018304813508c75438"
    sha256 cellar: :any_skip_relocation, catalina:     "35e06ba99b79f94b7e544526f0f239133ffcb5f34efd11289f074bc6b13a512e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7f9590d57d4beb491fb7efd49bb405044d4661c32934a9615a72e8fbfc732457"
  end

  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
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
