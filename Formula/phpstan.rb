class Phpstan < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpstan.org/"
  url "https://github.com/phpstan/phpstan/releases/download/0.11.2/phpstan.phar"
  sha256 "3d87481af8e4b1ca4f8a51e576918afd92c176bb65adbe23a738bb1dca546c5e"

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpstan.phar" => "phpstan"
  end

  test do
    assert_match /^OK \(3 tests, 3 assertions\)$/, shell_output("#{bin}/phpunit --bootstrap src/autoload.php tests/EmailTest")
  end
end
