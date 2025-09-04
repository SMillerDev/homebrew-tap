class PhpAutoloadPsrAT83 < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5d88beac3c904d4414c8d277edd3a37495cc36fdef13edd8effc210ca17a3dd5"
    sha256 cellar: :any_skip_relocation, ventura:       "02dcbc1eaee4fdf5299d1e763cdbed2aaa1fb555a64558e13234cebb7add94ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93911107ca444a541e429364c206f1e03033caeaef025510865ad5d249a08a0f"
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
