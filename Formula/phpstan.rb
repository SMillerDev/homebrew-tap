class Phpstan < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpstan.org/"
  url "https://github.com/phpstan/phpstan/releases/download/0.11.1/phpstan.phar"
  sha256 "4adb1ac4f1b4c65a870a03bb058111cd7d4e331027800bf135fb1592d2753b46"

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpstan.phar" => "phpstan"
  end

  test do
    assert_match /^OK \(3 tests, 3 assertions\)$/, shell_output("#{bin}/phpunit --bootstrap src/autoload.php tests/EmailTest")
  end
end
