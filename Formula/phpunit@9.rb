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
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpunit@9-9.6.23"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ad09f2fae8977d5edb8d6b8194459144ee3e62efaed044d67e12618c394a6d18"
    sha256 cellar: :any_skip_relocation, ventura:       "30222450d74885c4f014c6c58211cadcfe91cdc115b1cd10f0aaee90021f501b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45f16403bd28818be3bfcdd523da60179a43efa8a066e73e081194dae3d7d042"
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
