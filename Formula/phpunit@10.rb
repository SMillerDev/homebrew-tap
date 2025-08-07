class PhpunitAT10 < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-10.5.48.phar"
  sha256 "5489da9032965cd38de190e798445190939141a4557ffc98c30ba333da9baadd"
  license "BSD-3-Clause"

  livecheck do
    url "https://phar.phpunit.de/"
    regex(%r{/phpunit[._-]v?(10\.\d+(?:\.\d+)+)\.phar}i)
  end

  depends_on "php" => :test

  def install
    bin.install "phpunit-#{version}.phar" => "phpunit-#{version.major}"
  end

  test do
    (testpath/"src/autoload.php").write <<~PHP
      <?php
      spl_autoload_register(
          function($class) {
              static $classes = null;
              if ($classes === null) {
                  $classes = array(
                      'email' => '/Email.php'
                  );
              }
              $cn = strtolower($class);
              if (isset($classes[$cn])) {
                  require __DIR__ . $classes[$cn];
              }
          },
          true,
          false
      );
    PHP

    (testpath/"src/Email.php").write <<~PHP
      <?php
        declare(strict_types=1);

        final class Email
        {
            private $email;

            private function __construct(string $email)
            {
                $this->ensureIsValidEmail($email);

                $this->email = $email;
            }

            public static function fromString(string $email): self
            {
                return new self($email);
            }

            public function __toString(): string
            {
                return $this->email;
            }

            private function ensureIsValidEmail(string $email): void
            {
                if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                    throw new InvalidArgumentException(
                        sprintf(
                            '"%s" is not a valid email address',
                            $email
                        )
                    );
                }
            }
        }
    PHP

    (testpath/"tests/EmailTest.php").write <<~PHP
      <?php
      declare(strict_types=1);

      use PHPUnit\\Framework\\TestCase;

      final class EmailTest extends TestCase
      {
          public function testCanBeCreatedFromValidEmailAddress(): void
          {
              $this->assertInstanceOf(
                  Email::class,
                  Email::fromString('user@example.com')
              );
          }

          public function testCannotBeCreatedFromInvalidEmailAddress(): void
          {
              $this->expectException(InvalidArgumentException::class);

              Email::fromString('invalid');
          }

          public function testCanBeUsedAsString(): void
          {
              $this->assertEquals(
                  'user@example.com',
                  Email::fromString('user@example.com')
              );
          }
      }

    PHP
    assert_match(/^OK \(3 tests, 3 assertions\)$/,
      shell_output("#{bin}/phpunit-#{version.major} --bootstrap src/autoload.php tests/EmailTest.php"))
  end
end
