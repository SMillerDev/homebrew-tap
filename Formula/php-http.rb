class PhpHttp < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.0.0.tgz"
  sha256 "ea9a508578cffd428baf7b78f6d1618badedf3175be06b0809588a8b48889d5f"
  head "https://github.com/m6w6/ext-http.git"

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"
  depends_on "php-raphf"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin/"php-config"} --extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "pecl_http-#{version}"
    system Formula["php"].bin/"phpize"

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=/usr/local/lib
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
      --with-http-libcurl-dir=#{MacOS.sdk_path_if_needed}/usr
      --with-http-libicu-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/http.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-http.ini"
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
