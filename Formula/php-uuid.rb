class PhpUuid < Formula
  desc "UUID Extension for PHP"
  homepage "https://pecl.php.net/uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uuid-1.2.1"
    sha256 cellar: :any,                 arm64_sonoma: "452e3a14218f98af13894f7565ce5a7713f369f354f30f66fa4b9b030dea4777"
    sha256 cellar: :any,                 ventura:      "f536ba295c7e506ebf0abd14a24c0a1ccd19628d82a217762e506aff639a23f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6af67a2e4f9de3f10331d82299e1d8870a7218b158e9a3f255062c12de91b90e"
  end

  disable! date: "2025-01-01", because: "has been replaced by shivammathur/extensions/uuid@8.4",
replacement: "shivammathur/extensions/uuid@8.4"

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
