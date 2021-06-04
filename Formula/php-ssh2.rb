class PhpSsh2 < Formula
  desc "SSH2 Extension for PHP"
  homepage "https://pecl.php.net/ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  head "https://git.php.net/repository/pecl/networking/ssh2.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-ssh2-1.3.1"
    sha256                               catalina:     "f90bbe34026429a959813b4b4c5aae2744b2bd8fbda84bec5f8abc1b80897bbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3189a4208def169a45f132e986ff9e147d045d2a7e28676492322d82250254e7"
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
