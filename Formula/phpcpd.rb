class Phpcpd < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpcpd-6.0.3.phar"
  sha256 "2cbaea7cfda1bb4299d863eb075e977c3f49055dd16d88529fae5150d48a84cb"
  head "https://github.com/sebastianbergmann/phpcpd.git"

  depends_on "php" => :test

  def install
    bin.install "phpcpd-#{version}.phar" => "phpcpd"
  end
end
