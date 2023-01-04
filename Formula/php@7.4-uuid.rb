class PhpAT74Uuid < Formula
  desc "UUID Extension for PHP"
  homepage "https://pecl.php.net/uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git"

  livecheck do
    url :head
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-uuid-1.2.0"
    sha256 cellar: :any_skip_relocation, catalina: "8a1acd99d077387e8a6509578c87db45c5be6781ee9d95eaeae53c1b6c503aab"
  end

  depends_on "autoconf" => :build
  depends_on :macos
  depends_on "ossp-uuid"
  depends_on "php@7.4"

  patch do
    # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
    # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
    url "https://github.com/SMillerDev/pecl-networking-uuid/commit/90a448026454af4e3b76fa514dca583a1d31d7e5.patch?full_index=1"
    sha256 "c590c2045cf9837e9c97f1bfd078b615cf32d4d4c2995a793bc3691b9a0c29ee"
    directory "uuid-1.2.0"
  end

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    chdir "uuid-#{version}" do
      system Formula["php@7.4"].bin/"phpize"
      configure_args = %W[
        --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
        --with-uuid=#{Formula["ossp-uuid"].opt_include}
      ]
      system "./configure", *configure_args
      system "make"
      (lib/module_path).install "modules/uuid.so"
    end
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-uuid.ini"
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
    assert_match "uuid", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
