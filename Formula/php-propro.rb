class PhpPropro < Formula
  desc "ProPro Extension for PHP"
  homepage "https://pecl.php.net/propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "propro-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    (lib/module_path).install "modules/propro.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].php_version/"conf.d"/"ext-propro.ini"
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
    assert_match "propro", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
