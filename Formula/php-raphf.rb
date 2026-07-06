class PhpRaphf < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf-2.0.1_5"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c50c0ce163debca8f6168881b8396f63d5dfea4abeb11134c16cf62b1aaf8554"
    sha256 cellar: :any,                 arm64_linux:  "16659744e048b9fe086d09d64ccfa67bacc9404c5bb376f2808cd683d523d2d1"
    sha256 cellar: :any,                 x86_64_linux: "48ca4bd7ea77bb7269a8b29443a4f0ef2956a67b988381fe7d28b928677b6f05"
  end

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
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php"].version.major_minor}/conf.d/10-ext-raphf.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/raphf.so\""
    else
      ext_config_path.write <<~EOS
        [raphf]
        extension="#{opt_lib/module_path}/raphf.so"
      EOS
    end
  end

  test do
    assert_match "raphf", shell_output("#{formula_opt_bin("php")}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
