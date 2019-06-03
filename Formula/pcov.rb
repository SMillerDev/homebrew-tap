class Pcov < Formula
  desc "CodeCoverage compatible driver for PHP7"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.4.tar.gz"
  sha256 "5091503f09493a83b1ce7f674bf1c153cf204a6c350658274e740857300e7173"

  depends_on "php"

  def module_path
    extension_dir = Utils.popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
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
    ext_config_path = etc/"php"/Formula["php"].php_version/"conf.d"/"ext-pcov.ini"
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
