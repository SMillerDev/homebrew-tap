class PhpAT74Pcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-pcov-1.0.9"
    sha256 cellar: :any_skip_relocation, catalina:     "66e88569e1be91ebdef074524b917daa3c5b9b946ebfc128cd65037ad16eed05"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ba3909826752582c013d0c4c45849248d4df64e536fdf6fd51d15930920be880"
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
