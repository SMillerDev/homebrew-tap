class PhpHttp < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.2.tgz"
  sha256 "c338afd29259f0093f07f4e99b80705a2d5bb046c7ab32e5938eef29bbb63a6e"
  revision 1
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http-4.2.2_1"
    sha256 cellar: :any,                 big_sur:      "adf0b9ff5d421770aabc288ea89b20193e2ca2782954ef18a8d6e000cbc1bd80"
    sha256 cellar: :any,                 catalina:     "3458f3d25d1db6c04d1c187567b86ed86040a0c4cba4d7277fcd0e69da2e1aa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f0f127660352158f1d15c907b25f934588c90afc58d565fadb71d927fb7103ea"
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
