class Phpcpd < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpcpd-5.0.2.phar"
  sha256 "12e94af9928be2f33fd394d2cc5d96b3925de24d614381d06b3096cc9eeabbcb"
  head "https://github.com/sebastianbergmann/phpcpd.git"

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpcpd-#{version}.phar" => "phpcpd"
  end
end
