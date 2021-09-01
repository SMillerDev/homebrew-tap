class PhpHttp < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.0.tgz"
  sha256 "9898c2e2b2c78ce11fca1cb3a151ff201ce957afb8b8c1985a52dd5eae35812e"
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http-4.2.0"
    sha256                               catalina:     "672360895ed9d39243de52f45ec0a5dc2d7c8b9743ff59207b1e98d0d5c05e20"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1559fd3f36b267963aa2555eeb1e6970073b9ede2a7239b265bd1ef49022657"
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
        extension=\"#{opt_lib/module_path}/http.so\"
      EOS
    end
  end

  test do
    assert_match "http", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
