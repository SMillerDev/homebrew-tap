class PhpUuid < Formula
  desc "UUID Extension for PHP"
  homepage "https://pecl.php.net/uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git"

  depends_on "autoconf" => :build
  depends_on "php"
  depends_on "util-linux"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    chdir "uuid-#{version}" if build.stable?
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-uuid=#{Formula["util-linux"].opt_prefix}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uuid.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-uuid.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/uuid.so\""
    else
      ext_config_path.write <<~EOS
        [uuid]
        extension="#{opt_lib/module_path}/uuid.so"
      EOS
    end
  end

  test do
    assert_match "uuid", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
