class PhpAT74Http < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.4.tgz"
  sha256 "37354ff7680b9b9839da8b908fff88227af7f6746c2611c873493af41d54f033"
  head "https://github.com/m6w6/ext-http.git"

  livecheck do
    skip "latest for php 7.4"
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php@7.4-http-3.2.4"
    sha256                               catalina:     "9de107cc592c297aa3498286d64011ef9a0a97dceae285a0e08f4c7aab502730"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e30ca54431e44d6282c09067f457622fd5577ae7f0063bfedc2d82ef5d363947"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@7.4"
  depends_on "php@7.4-propro"
  depends_on "php@7.4-raphf"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@7.4"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "pecl_http-#{version}"
    system Formula["php@7.4"].bin/"phpize"

    mkdir "ext"
    # link in the raphf extension header
    cp_r "#{Formula["php@7.4-raphf"].include}/raphf@7.4", "ext/raphf"

    # link in the propro extension header
    cp_r "#{Formula["php@7.4-propro"].include}/propro@7.4", "ext/propro"

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=/usr/local/lib
      --with-php-config=#{Formula["php@7.4"].opt_bin/"php-config"}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
      --with-http-libcurl-dir=#{MacOS.sdk_path_if_needed}/usr
      --with-http-libicu-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/http.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php@7.4"].version.major_minor/"conf.d"/"ext-http.ini"
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
    assert_match "http", shell_output("#{Formula["php@7.4"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
