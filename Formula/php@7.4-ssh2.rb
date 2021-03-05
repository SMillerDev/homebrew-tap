class PhpAT74Ssh2 < Formula
  desc "SSH2 Extension for PHP"
  homepage "https://pecl.php.net/ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  head "https://git.php.net/repository/pecl/networking/ssh2.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-ssh2-1.3.1"
    sha256                               catalina:     "b438e4ff1a5e01626f48e85271a348f6af4deacc3af0eb7c82dfccb500219cf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff3bb21115ff67d2c058f7ce0971984b1a18d0d50a741cc4c20c102d235fcb80"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build

  depends_on "libssh2"
  depends_on "php@7.4"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "ssh2-#{version}"
    system Formula["php@7.4"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
      --with-ssh2=#{Formula["libssh2"].opt_prefix}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/ssh2.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-ssh2.ini"
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
    assert_match "ssh2", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
