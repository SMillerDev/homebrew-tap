class PhpunitAT11 < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-11.5.55.phar"
  sha256 "9d58674e826904add392d08c5ba3e9173ff36b242683cd8f368a476d2513b3bd"
  license "BSD-3-Clause"

  livecheck do
    url "https://phar.phpunit.de/"
    regex(%r{/phpunit[._-]v?(11\.\d+(?:\.\d+)+)\.phar}i)
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpunit@11-11.5.55"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8cdb409486aa3643d4a13e40d6c65322506b0a075f021fa5d6d0cedc730e5886"
    sha256 cellar: :any_skip_relocation, tahoe:        "ecbe430ac7e00e8f5f737b573db9fd88efd023af75cbe94c45e58df05ced12c1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9218a26ccadcf46919e85752c65ed251285875fb7e79d2e3fe76b62f9702a637"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "812a10699f0fe73bece1f2921ccf6ec4fa20c60e4723648eb0f12382492689aa"
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
