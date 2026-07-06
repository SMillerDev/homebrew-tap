class PhpunitAT10 < Formula
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-10.5.63.phar"
  sha256 "3160398ef3e1ac041866fab0e88bdbc46349c7420824b750d2ede9a58ead1ba8"
  license "BSD-3-Clause"

  livecheck do
    url "https://phar.phpunit.de/"
    regex(%r{/phpunit[._-]v?(10\.\d+(?:\.\d+)+)\.phar}i)
  end

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpunit@10-10.5.63"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9421bad015a9650adcb88e034eaa61d0f898e6683cef8e7fa9ccb286958e236f"
    sha256 cellar: :any_skip_relocation, tahoe:        "4916d37917632e2fc00d7a7adef6a8317591eee3da7ef0348e2d8f7bb811c01a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6241e0fb07cd3c69e3d1db309a98dbec5fab29be2729c0825df1a806c2ea7740"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b38ad1c012272d7e844573437a30029b75376a68cb8d40c8c7a6404ab25dccb"
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
