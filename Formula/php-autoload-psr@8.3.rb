class PhpAutoloadPsrAT83 < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr@8.3-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "24c0e1f0de57dcaa69371a8bcb64de57fe846f816358eccf8e6815f86dd89ff4"
    sha256 cellar: :any_skip_relocation, ventura:       "d79e98cd21fbe09e021e416c79bfa7897a4804e065f96502644f5e92568a2c79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5cd3d5224546dbef321d050c8ba988bce3c297e69274cef0ca861a5b3740d4b"
  end

  depends_on "autoconf" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@8.3"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php@8.3"].bin/"phpize"
    system "./configure", "--with-php-config=#{Formula["php@8.3"].opt_bin/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/ext-autoload_psr.ini"
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
    assert_match "autoload_psr", shell_output("#{Formula["php@8.3"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
