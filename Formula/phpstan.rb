class Phpstan < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpstan.org/"
  url "https://github.com/phpstan/phpstan/releases/download/0.11.5/phpstan.phar"
  sha256 "49b0ccea56a27cd379747a5f5a24b75e8c8f382fd593188c075bb5921da5538d"

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpstan.phar" => "phpstan"
  end

  test do
    assert_match /^OK \(3 tests, 3 assertions\)$/, shell_output("#{bin}/phpunit --bootstrap src/autoload.php tests/EmailTest")
  end
end
