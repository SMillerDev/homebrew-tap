class PhpRaphf < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf-2.0.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "740d05b8a6c543bd17efba2cc1a4b61428cddad15936cad3f710ddb21f9ccecb"
    sha256 cellar: :any,                 arm64_linux:  "784101d392c2f5e5d6e1655b30370b65fab93550074188c3f30c452c201ff133"
    sha256 cellar: :any,                 x86_64_linux: "504af0e30b1588a22765acd3b8bf62adaf91f8f5c18b18135cf07a6640cdfd7a"
  end

  disable! date: "2026-09-01", because: :unsupported

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{formula_opt_bin("php")}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "raphf-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{formula_opt_bin("php")/"php-config"}
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
    unless_path_exists "php/8.5/conf.d/ext-raphf.ini", base: :etc do
      copy "ext-raphf.ini", "php/8.5/conf.d/ext-raphf.ini",
           source_base: :pkgetc, target_base: :etc
    end
  end

  test do
    assert_match "raphf", shell_output("#{formula_opt_bin("php")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
