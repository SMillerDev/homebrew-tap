class PhpUuid < Formula
  desc "UUID Extension for PHP"
  homepage "https://pecl.php.net/uuid"
  url "https://pecl.php.net/get/uuid-1.1.0.tgz"
  sha256 "981c1c2fec77aaffec29242c29a346bc6ec2115053e9b6b5afb4a4e149a2333f"
  head "https://github.com/php/pecl-networking-uuid.git"

  depends_on "autoconf" => :build
  depends_on "ossp-uuid"
  depends_on "php"

  patch do
    # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
    # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
    url "https://gist.githubusercontent.com/romainneutron/fe068c297413aee565d5/raw/28d6ba0b6e902e82e71bb9a1ed768c836a8161e4/php-uuid-1.0.4"
    sha256 "5f0664d5c4f55d4f6c037dab9f198e697afa3f9266854ed3945d7697fdb692b2"
  end

  def module_path
    extension_dir = Utils.popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "uuid-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-uuid=#{Formula["ossp-uuid"].opt_include}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uuid.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].php_version/"conf.d"/"ext-uuid.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/uuid.so\""
    else
      ext_config_path.write <<~EOS
        [uuid]
        extension=\"#{opt_lib/module_path}/uuid.so\"
      EOS
    end
  end

  test do
    assert_match "uuid", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
