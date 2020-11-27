class PhpSqllint < Formula
  desc "Command-line tool to validate (syntax check) SQL files"
  homepage "https://github.com/cweiske/php-sqllint"
  url "https://github.com/cweiske/php-sqllint/releases/download/v0.2.3/php-sqllint-0.2.3.phar"
  sha256 "a02b50ee2bfd20a67da9c6786b72611c9c1bdd969ed1fa1a3565644881b095df"
  license "AGPL-3.0-or-later"

  bottle :unneeded

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
