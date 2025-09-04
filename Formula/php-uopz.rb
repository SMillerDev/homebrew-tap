class PhpUopz < Formula
  desc "UOPZ Extension for PHP"
  homepage "https://pecl.php.net/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-uopz-7.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "3f5482506c3d7936256aac25e8e09e3bba922f9f1465a69753b9b5409ecaacda"
    sha256 cellar: :any_skip_relocation, catalina:     "d7abad1fc95b91147c63cce9b94bbb907d503b044cae0dbf77e5245bbb298a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "708f8e8fe776f1031fb1bda84bdb91fda85056d61c829a939baf7131c0f7a8f8"
  end

  head do
    url "https://github.com/krakjoe/uopz.git"

    patch do
      url "https://github.com/krakjoe/uopz/commit/1e1b875ec98fc39930e136e7e9c5e96bacb393bd.patch?full_index=1"
      sha256 "fb0eb7d924b8ab2556bee12a6656b653b04c1ea7739c372bd1eec5c58a9d749e"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/5a0c2bbe0df5e9db7421dd9f04409f583e993e65.patch?full_index=1"
      sha256 "651da7279d5f3a52a43b2d17d07a4acfef1e100f3ccc60fe0722ac9f18d578d2"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/f39ef577173bd9e2052c5e79e7b6f5f6b7101c63.patch?full_index=1"
      sha256 "1594dbca1ef03b3a2b67d9555c359b35015c5927d496570a7831b3355ce64779"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/5af3a28876ea9ad6baf59d5ba548bff01a7947ba.patch?full_index=1"
      sha256 "18c8376995704821533ae2139513297dde28c085e6460209dfd62bd58b75b021"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/28a21eccfdece55c1d92ecc275ca5918765d8320.patch?full_index=1"
      sha256 "ee0bcca4b9f58ffa412ab8ca006151d7d7b5ec6a326fdfa8ac2e552d23f156b2"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/498d4eb82328e37625b2dfaa53c478db713772cc.patch?full_index=1"
      sha256 "b541f1c7594e0bbf8d1a39bfe095e98b816aa507c85d70633cc7c1b085bc5691"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/238b04d08a8aadce4cef5dff118a96a36387aa85.patch?full_index=1"
      sha256 "5666de9ba750ca1cc71eac5190f3dabe693e29720e2af0199cdb8c12ff6e989b"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/a58797fdb7cbb36016ffd7a3ca75ca1d1d02897a.patch?full_index=1"
      sha256 "fcac11a13078bb6f3979272c23f5900bce4ec9327a9e6402e0a2d0d01af99ac8"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/1f7939adec3fab67fb241f920363425739f616b7.patch?full_index=1"
      sha256 "c3882815d4384e21ace1d423b85c6e8c1ef93624554faa94f4e8599c2b201121"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/8af6a49a25f6da5cd6523e8ed65d0241da6df32a.patch?full_index=1"
      sha256 "313a349e5f5ce0085bc8f747057da84595e9fbdfcdf238938f71cde2249572a1"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/9db5de74fb355caf4e0a256d96e13edfd434dc7c.patch?full_index=1"
      sha256 "8d6a192d45b9a11061e43d946c70ec71e8a9f43540fcc30cbec314dc86817df1"
    end

    patch do
      url "https://github.com/krakjoe/uopz/commit/971d748fa0f73cd8b9064f7a83b11972718a9f2a.patch?full_index=1"
      sha256 "79c3cb82a5f3f35d8a5f7e10b7829501396e27910f7be468964ed08b2d73f84c"
    end
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
    cd "uopz-#{version}" unless build.head?
    system Formula["php"].bin/"phpize"
    configure_args = %W[
      --with-php-config=#{Formula["php"].opt_bin/"php-config"}
    ]
    system "./configure", *configure_args
    system "make"
    (lib/module_path).install "modules/uopz.so"
  end

  def post_install
    ext_config_path = etc/"php"/Formula["php"].version.major_minor/"conf.d"/"ext-uopz.ini"
    if ext_config_path.exist?
      inreplace ext_config_path,
        /extension=.*$/, "extension=\"#{opt_lib/module_path}/uopz.so\""
    else
      ext_config_path.write <<~EOS
        [uopz]
        extension="#{opt_lib/module_path}/uopz.so"
      EOS
    end
  end

  test do
    assert_match "uopz", shell_output("#{Formula["php"].opt_bin}/php -m").downcase,
      "failed to find extension in php -m output"
  end
end
