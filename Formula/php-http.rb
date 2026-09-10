class PhpHttp < Formula
  desc "Pecl HTTP Extension for PHP"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  head "https://github.com/m6w6/ext-http.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-http-4.3.1"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:  "70fa36634137f9c312404a442aade27f5390d21950e8c9e658d63ae911e4cc2a"
    sha256 cellar: :any, arm64_linux:  "b25bba30cd7925c68d5cdcb5e54e653640cedfbe9ce9d91741897189d1a93553"
    sha256 cellar: :any, x86_64_linux: "e029aba6dc5b51737683bbec1a4123a4e01aa480af60608094eb1169ae551f52"
  end

  disable! date: "2026-09-01", because: :unsupported

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@76"
  depends_on "openssl@3"
  depends_on "php"
  depends_on "php-raphf"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "pecl_http-#{version}"
    system Formula["php"].bin/"phpize"

    mkdir "ext"
    # link in the raphf extension header
    cp_r "#{Formula["php-raphf"].include}/raphf", "ext/raphf"

    sdkpath = ""
    sdkpath = MacOS.sdk_path if OS.mac?

    configure_args = %W[
      --with-http
      --without-http-libidn-dir
      --without-http-libidn2-dir
      --without-http-libidnkit-dir
      --without-http-libidnkit2-dir
      --with-libdir=#{HOMEBREW_PREFIX}/lib
      --with-php-config=#{formula_opt_bin("php")/"php-config"}
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
    unless_path_exists "php/8.5/conf.d/ext-http.ini", base: :etc do
      copy "ext-http.ini", "php/8.5/conf.d/ext-http.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "http", shell_output("#{formula_opt_bin("php")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
