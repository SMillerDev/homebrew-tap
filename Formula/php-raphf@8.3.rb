class PhpRaphfAT83 < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf@8.3-2.0.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7702fa08958a6d568da5a9443cbd54563b9400e9e4a74a4934e36a7691f6e20a"
    sha256 cellar: :any,                 arm64_linux:  "480970f51c32d8d586333fb96764fe03ddbbfb09df005cfb691cd9a8cabbaaa8"
    sha256 cellar: :any,                 x86_64_linux: "ce7d8e3b7322eeb46471daedc4e2b863e3c629961813c3d0f83a36bcd1406b27"
  end

  disable! date: "2026-09-01", because: :unsupported

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php@8.3")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "raphf-#{version}"
    system Formula["php@8.3"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{formula_opt_bin("php@8.3")/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"raphf"
    (include/"raphf").install %w[php_raphf.h src/php_raphf_api.h]
    (lib/module_path).install "modules/raphf.so"
    (pkgetc/"ext-raphf.ini").write <<~EOS
      [raphf]
      extension="#{opt_lib/module_path}/raphf.so"
    EOS
  end

  post_install_steps do
    unless_path_exists "php/8.3/conf.d/ext-raphf.ini", base: :etc do
      copy "ext-raphf.ini", "php/8.3/conf.d/ext-raphf.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "raphf", shell_output("#{formula_opt_bin("php@8.3")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
