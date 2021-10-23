class Phpcpd < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpcpd-6.0.3.phar"
  sha256 "2cbaea7cfda1bb4299d863eb075e977c3f49055dd16d88529fae5150d48a84cb"
  head "https://github.com/sebastianbergmann/phpcpd.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpcpd-6.0.3"
    sha256 cellar: :any_skip_relocation, catalina:     "6240fd419cc6c230bebb336a828dc0101d05d137262b192acc934fd27b3b5d7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ccd7c16c11fcd5dfc736b81b0345ffb42dcc9e8925a4a01e8b5e4a555704e972"
  end

  depends_on "php" => :test

  def install
    bin.install "phpcpd-#{version}.phar" => "phpcpd"
  end
end
