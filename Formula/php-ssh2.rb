class PhpSsh2 < Formula
  desc "SSH2 Extension for PHP"
  homepage "https://pecl.php.net/ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  revision 1
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-ssh2-1.3.1_1"
    sha256                               big_sur:      "db7bfb9a7289f6b68d3024f7c66cc1f5067c5a6c8cfd4be9a74270142c486b7d"
    sha256                               catalina:     "3415a4ffaad18173446f747aac93d9d282bd4be5e138572cc3b5288e9978800c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "74ca83a32abb520b6393c24716707c44a1d1888e0873e784341649f302516453"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build

  depends_on "libssh2"
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "ssh2-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-ssh2=#{Formula["libssh2"].opt_prefix}
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
