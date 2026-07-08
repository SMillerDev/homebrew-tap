class PhpunitAT11 < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-11.5.56.phar"
  sha256 "915fa161f496dc04a45cd6032855879bca0bab644048cd0516982dffe678e9f1"
  license "BSD-3-Clause"

  livecheck do
    url "https://phar.phpunit.de/"
    regex(%r{/phpunit[._-]v?(11\.\d+(?:\.\d+)+)\.phar}i)
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpunit@11-11.5.56"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "837955f46234940cf92180311b426028c204fc4724a6de1f96c9a3112a3181d4"
    sha256 cellar: :any_skip_relocation, tahoe:        "725c5597f20e33fe67bb3a0c72fe8f58e15b5ef876867a3584e65005bc6c3b01"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bf8f2643b78ee0fc5d3d8a00e32403b42039fafcff532e7bd3334964dd33c2bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4330cb9fe6a21a24b5782bb3f213c46ab4916adc2d453791c58931d50740b73a"
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
