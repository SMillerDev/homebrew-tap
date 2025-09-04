class PhpRaphfAT83 < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf@8.3-2.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "889411b2aade2ce812a9fc184d2eea4b0e1dc60283c4ce11782072bef3a83bb4"
    sha256 cellar: :any_skip_relocation, ventura:      "abf6d13afba8b1900f32e37c3b3e7764a32c57829d340a3444e0d400935018ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be5361c9fa275e835e66bff48b38effdf05df60226f6de365cb4f22393a01ae8"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php@8.3"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php@8.3"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "raphf-#{version}"
    system Formula["php@8.3"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php@8.3"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"raphf"
    (include/"raphf").install %w[php_raphf.h src/php_raphf_api.h]
    (lib/module_path).install "modules/raphf.so"
  end

  def post_install
    ext_config_path = etc/"php/#{Formula["php@8.3"].version.major_minor}/conf.d/10-ext-raphf.ini"
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
    assert_match "raphf", shell_output("#{Formula["php@8.3"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
