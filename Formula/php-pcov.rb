class PhpPcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-pcov-1.0.11"
    sha256 cellar: :any_skip_relocation, big_sur:      "cd2b83d6f865273eaff6b09ca3e9f43fb26a2e6c47c5c9c76ffd69a2030048a7"
    sha256 cellar: :any_skip_relocation, catalina:     "f7a33e22bcfdcf71e61101dd4a31b88e961fe5430a6289066804d3cbf96ae390"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5bdd26fcd77c0f9e628db7356c1d9bd517b3ec59c4317961ab314be415edb91"
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
