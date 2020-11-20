class PhpSsh2 < Formula
  desc "SSH2 Extension for PHP"
  homepage "https://pecl.php.net/ssh2"
  url "https://pecl.php.net/get/ssh2-1.2.tgz"
  sha256 "7f9f205f5b555692f7b010ffb68a01e21860176062f2ec14dc577d994cecd929"
  head "https://git.php.net/repository/pecl/networking/ssh2.git"

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "ssh2-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/ssh2.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-ssh2.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/ssh2.so\""
    else
      ext_config_path.write <<~EOS
        [ssh2]
        extension=\"#{opt_lib/module_path}/ssh2.so\"
      EOS
    end
  end

  test do
    assert_match "ssh2", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
