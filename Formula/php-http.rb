class PhpHttp < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http-4.2.3"
    sha256 cellar: :any,                 big_sur:      "d6264c8465be627a690ba2646354348a0e150d7e21b6562e1843db7b7247830a"
    sha256 cellar: :any,                 catalina:     "c480b03bb8c002a4dc5c26f26b9db9b3cb35ef1af2e292d804c687d2edab51e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "277cb916065353a5776efb441f3826c00cdb896d491f1362cbba9f12cb2515b4"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "curl"
  depends_on "php"
  depends_on "php-raphf"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "pecl_http-#{version}"
    system Formula["php"].bin/"phpize"

    mkdir "ext"
    # link in the raphf extension header
    cp_r "#{Formula["php-raphf"].include}/raphf", "ext/raphf"

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=/usr/local/lib
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
      --with-http-libcurl-dir=#{Formula["curl"].opt_lib}
      --with-http-libicu-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/http.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"20-ext-http.ini"
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
    assert_match "http", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
