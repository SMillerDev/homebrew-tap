class PhpAT74Pcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-pcov-1.0.11"
    sha256 cellar: :any_skip_relocation, big_sur:      "cca55ca2f54e27b7c73952d54f779ad681bd04c5bf5be6724174ebc295e8aa3b"
    sha256 cellar: :any_skip_relocation, catalina:     "22085c13ddbed314b71996fc6660cb998572183bc8e580af96e1f7c643fd7f12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f61e3b7c9721e55dfb3a16ff45eb4d45eb0fddace8d91ac883cc226fa4224f0d"
  end

  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
      --enable-pcov
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/pcov.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-pcov.ini"
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
    assert_match "pcov", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
