class PhpunitAT9 < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-9.6.23.phar"
  sha256 "f195cd37de1bd14b4b60aa90af5bea95e8506d828c0dbbcf8dca03d78a38e79f"
  license "BSD-3-Clause"

  livecheck do
    url "https://phar.phpunit.de/"
    regex(%r{/phpunit[._-]v?(9\.\d+(?:\.\d+)+)\.phar}i)
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpunit@9.5-9.5.28"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "587bb4a22c6100aaf0c8149f20cb0dbfd9e1957a87c32b708cb080dbfe2426a2"
    sha256 cellar: :any_skip_relocation, ventura:      "a506b7e2a665662b8165378e98976e5ab4cbc97b2c0e556060995bb513981ce1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6a85e6e7f58e4d7e995b16e29291ee24e8017482cc5164b3fe834d1b58770fa8"
  end

  depends_on "php" => :test

  def install
    bin.install "phpunit-#{version}.phar" => "phpunit-#{version.major}"
    # Create a symlink to retain for compatibility with previous versions
    bin.install_symlink "phpunit-#{version.major}" => "phpunit"
  end

  test do
    (testpath/"src/autoload.php").write <<~EOS
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
    EOS

    (testpath/"src/Email.php").write <<~EOS
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
    EOS

    (testpath/"tests/EmailTest.php").write <<~EOS
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

    EOS
    assert_match(/^OK \(3 tests, 3 assertions\)$/,
      shell_output("#{bin}/phpunit-#{version.major} --bootstrap src/autoload.php tests/EmailTest.php"))
  end
end
