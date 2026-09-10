class PhpAutoloadPsr < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr-0.2.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0cc226ccc610d8a1a04498994e6e40e79963623847c3d115e908d1a9770386d5"
    sha256 cellar: :any,                 arm64_linux:  "3f592273d7050a0c6b211a35897a80038796a5a01a85716398b0c63e50154bd1"
    sha256 cellar: :any,                 x86_64_linux: "f141d1dfed35391bd6c67b7acc35eec5d05a615ed554ffb5e2f60289b7166537"
  end

  disable! date: "2026-09-01", because: :unsupported

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
    (pkgetc/"ext-autoload-psr.ini").write <<~EOS
      [autoload_psr]
      extension="#{opt_lib/module_path}/autoload_psr.so"
    EOS
  end

  post_install_steps do
    unless_path_exists "php/8.5/conf.d/ext-autoload-psr.ini", base: :etc do
      copy "ext-autoload-psr.ini", "php/8.5/conf.d/ext-autoload-psr.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{formula_opt_bin("php")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
