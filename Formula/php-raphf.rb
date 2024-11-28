class PhpRaphf < Formula
  desc "Raphf Extension for PHP"
  homepage "https://pecl.php.net/raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  revision 5
  head "https://github.com/m6w6/ext-raphf.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-raphf-2.0.1_5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8e68874fc3668fa0f03a60f2a6a185111314e5c4db54a0a1f2e5b9df0d0ae40e"
    sha256 cellar: :any_skip_relocation, ventura:      "05514853bdbb3fda890762ed92952f13eb3fc5b5a4c0181d1233a1ce7bc85e78"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f4885e5b6345233f6c2dd4fd50707d7ed44a8abbd75bac35484fa767547a60b7"
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "php"

  def module_path
    extension_dir = Utils.safe_popen_read("#{Formula["php"].opt_bin}/php-config", "--extension-dir").chomp
    php_basename = File.basename(extension_dir)
    "php/#{php_basename}"
  end

  def install
    cd "raphf-#{version}"
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"

    mkdir_p include/"raphf"
    (include/"raphf").install %w[php_raphf.h src/php_raphf_api.h]
    (lib/module_path).install "modules/raphf.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"10-ext-raphf.ini"
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
    assert_match "raphf", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
