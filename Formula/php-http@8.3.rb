class PhpHttpAT83 < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.6.tgz"
  sha256 "cd33230050b3f7c5ddb6f4383ce2a81f0bcdb934432029eec72ebf0f942b876d"
  head "https://github.com/m6w6/ext-http.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http@8.3-4.2.6"
    rebuild 2
    sha256 cellar: :any, arm64_linux:  "f9c85f6f56ccb7989754c6ae3819b761d0719c8bdf18b3629fb1a84a00ca669f"
    sha256 cellar: :any, x86_64_linux: "6b70c6ba9d90e667f879c3008787b1b4b70c96738886bf6f8c1977004962a57e"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "php-raphf@8.3"
  depends_on "php@8.3"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php@8.3")}/php-config", "--extension-dir").chomp
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
    sdkpath = MacOS.sdk_path if OS.mac?

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=#{HOMEBREW_PREFIX}/lib
      --with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}
      --with-http-zlib-dir=#{sdkpath}/usr
      --with-http-libcurl-dir=#{formula_opt_lib("curl")}
      --with-http-libicu-dir=#{sdkpath}/usr
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/http.so"
    (pkgetc/"ext-http.ini").write <<~EOS
      [pecl_http]
      extension="#{opt_lib/module_path}/http.so"
    EOS
  end

  post_install_steps do
    unless_path_exists "php/8.3/conf.d/ext-http.ini", base: :etc do
      copy "ext-http.ini", "php/8.3/conf.d/ext-http.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "http", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
