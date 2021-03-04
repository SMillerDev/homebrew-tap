class PhpAT74Propro < Formula
  desc "ProPro Extension for PHP"
  homepage "https://pecl.php.net/propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-propro-2.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "c39b80b1edf5de40187ffd998ed746d88b91b928a995f492652fcf054703c9e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46a7896041a80639beda33671637aaca222fc5a5801d6ca197ce8279ac9e1376"
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
    cd "propro-#{version}"
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"propro@7.4"
    (include/"propro@7.4").install %w[php_propro.h src/php_propro_api.h]
    (lib/module_path).install "modules/propro.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-propro.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/propro.so\""
    else
      ext_config_path.write <<~EOS
        [propro]
        extension=\"#{opt_lib/module_path}/propro.so\"
      EOS
    end
  end

  test do
    assert_match "propro", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
