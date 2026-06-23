class PhpAutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr-0.2.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "54e8ed56b3981c11a20e9466c2ee2ddae624ce8e97a9ede98fe42bf5356cf36c"
    sha256 cellar: :any,                 arm64_linux:  "0d50c1286a1778fc220227b20b0bdcc0c9690c626c9fe08c8e77d4e0ae9dbcd6"
    sha256 cellar: :any,                 x86_64_linux: "c8bae4cf02fa59769dfe47bc99d76e5dfa5ca82a5c57045b48daf26430f6a228"
  end

  depends_on "autoconf" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php"].bin/"phpize"
    system "./configure", "--with-php-config=#{formula_opt_bin("php")/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php"].version.major_minor}/conf.d/ext-autoload_psr.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/autoload_psr.so\""
    else
      ext_config_path.write <<~EOS
        [autoload_psr]
        extension="#{opt_lib/module_path}/autoload_psr.so"
      EOS
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{formula_opt_bin("php")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
