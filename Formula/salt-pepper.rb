class SaltPepper < Formula
  include Language::Python::Virtualenv

  desc "Python library and CLI scripts for accessing a remote salt-api instance"
  homepage "https://github.com/saltstack/pepper/"
  url "https://files.pythonhosted.org/packages/5a/e0/2aa7893ccd711fbb197e1b96038c47db9d903604e023a436521780775d5b/salt-pepper-0.7.6.tar.gz"
  sha256 "b75a641d4fd96663ae44fc7ce4aadb7e4c87b8ff30f7ac35479a282b99894749"
  license "Apache-2.0"

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    out = shell_output("#{bin}/pepper \
      --saltapi-url=https://localhost:8000 \
      --username='test' \
      --password='f' '*' test.ping 2>&1", 1)
    assert_match "Connection refused", out
  end
end
