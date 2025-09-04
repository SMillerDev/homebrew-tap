class PhpHttpAT83 < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.6.tgz"
  sha256 "cd33230050b3f7c5ddb6f4383ce2a81f0bcdb934432029eec72ebf0f942b876d"
  head "https://github.com/m6w6/ext-http.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http@8.3-4.2.6"
    sha256 cellar: :any,                 arm64_sonoma: "5a8f7786cd24077958a55643d21210c8cdce24d0d82b39e5a2e722754622a4fb"
    sha256 cellar: :any,                 ventura:      "6811be2b8e9e1cd72a6cb263f1639c1b94a963a8b3432d989f163365b9fa40ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32c48a7e80f6012f4e9aaf5b1796ff2ac253ddf6952c8572a320e638c00945dc"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "php-raphf@8.3"
  depends_on "php@8.3"

  uses_from_macos "zlib"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@8.3"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "pecl_http-#{version}"
    system Formula["php@8.3"].bin/"phpize"

    mkdir "ext"
    # link in the raphf extension header
    cp_r "#{Formula["php-raphf@8.3"].include}/raphf", "ext/raphf"

    sdkpath = ""
    sdkpath = MacOS.sdk_path_if_needed if OS.mac?

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=#{HOMEBREW_PREFIX}/lib
      --with-php-config=#{Formula["php@8.3"].opt_bin/"php-config"}
      --with-http-zlib-dir=#{sdkpath}/usr
      --with-http-libcurl-dir=#{Formula["curl"].opt_lib}
      --with-http-libicu-dir=#{sdkpath}/usr
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/http.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/20-ext-http.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/http.so\""
    else
      ext_config_path.write <<~EOS
        [pecl_http]
        extension="#{opt_lib/module_path}/http.so"
      EOS
    end
  end

  test do
    assert_match "http", shell_output("#{Formula["php@8.3"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
