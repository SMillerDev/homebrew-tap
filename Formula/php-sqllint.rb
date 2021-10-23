class PhpSqllint < Formula
  desc "Command-line tool to validate (syntax check) SQL files"
  homepage "https://github.com/cweiske/php-sqllint"
  url "https://github.com/cweiske/php-sqllint/releases/download/v0.2.3/php-sqllint-0.2.3.phar"
  sha256 "a02b50ee2bfd20a67da9c6786b72611c9c1bdd969ed1fa1a3565644881b095df"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/php-sqllint-0.2.3"
    sha256 cellar: :any_skip_relocation, catalina:     "5e758e3bca6f5c06680dd3ebdcb8edb083a5926ffb845998e9e597b1567e9c85"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "85812fa661667b6c5ebd2055b904ed20dcd7d5842faa6469fd72dba77bce06b7"
  end

  depends_on "php"

  def install
    bin.install "php-sqllint-#{version}.phar" => "sqllint"
  end

  test do
    (testpath/"test.sql").write <<~EOS
      CREATE TABLE test (
          uid INT(11) DEFAULT 0 NOT NULL
          pid INT(11) DEFAULT 0 NOT NULL
      );
    EOS

    assert_match "A comma or a closing bracket was expected", shell_output("#{bin}/sqllint test.sql", 10)
  end
end
