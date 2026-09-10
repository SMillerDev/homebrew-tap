class PhpAutoloadPsrAT83 < Formula
  desc "Autoload-PSR Extension for PHP"
  homepage "https://github.com/pprkut/autoload-psr"
  url "https://github.com/pprkut/autoload-psr/archive/refs/tags/0.2.1.tar.gz"
  sha256 "f089f837928f65aa73fbc39584ea0dfeb67fd39cb7e68c533386d188daf17604"
  head "https://github.com/pprkut/autoload-psr.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-autoload-psr@8.3-0.2.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "351984be46e8fcd32d2be652664d78f55badc668f1cd6ec8f569b5e66c266610"
    sha256 cellar: :any,                 arm64_linux:  "cf2fb19d736271103d03a106bf4b0d45dbf4e51e9304cde522043d3fcc4a437d"
    sha256 cellar: :any,                 x86_64_linux: "ade461816d6a8d159d7d2305f82d9933758f414b7dc970de3d45fda91bb5dedf"
  end

  depends_on "autoconf" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php@8.3")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    system Formula["php@8.3"].bin/"phpize"
    system "./configure", "--with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}"
    system "make"
    (lib/module_path).install "modules/autoload_psr.so"
    (pkgetc/"ext-autoload-psr.ini").write <<~EOS
      [autoload_psr]
      extension="#{opt_lib/module_path}/autoload_psr.so"
    EOS
  end

  post_install_steps do
    unless_path_exists "php/8.3/conf.d/ext-autoload-psr.ini", base: :etc do
      copy "ext-autoload-psr.ini", "php/8.3/conf.d/ext-autoload-psr.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "autoload_psr", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
