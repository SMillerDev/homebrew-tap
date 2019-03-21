class Phpstan < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpstan.org/"
  url "https://github.com/phpstan/phpstan/releases/download/0.11.4/phpstan.phar"
  sha256 "4346a3b509bddd5ce7b2dc741b1f55b813e47726d12acf9bb4936a11790d39b4"

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpstan.phar" => "phpstan"
  end

  test do
    assert_match /^OK \(3 tests, 3 assertions\)$/, shell_output("#{bin}/phpunit --bootstrap src/autoload.php tests/EmailTest")
  end
end
