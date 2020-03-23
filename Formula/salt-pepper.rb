class SaltPepper < Formula
  include Language::Python::Virtualenv

  desc "Library and CLI scripts for accessing a salt-api instance"
  homepage "https://saltstack.com"
  url "https://files.pythonhosted.org/packages/1b/3f/9213b4bab514aadc48f0a89d5bc218d9e042366c16eb75b0c0c3d7fdb134/salt-pepper-0.7.5.tar.gz"
  sha256 "9ca4daebbe15c4da0ca286d74f7361444cfd30fc6abc92afdc12cdc65bf406f2"
  head "https://github.com/saltstack/pepper.git"

  depends_on "python"

  def install
    virtualenv_create(libexec, "python")
    virtualenv_install_with_resources
  end

  test do
    assert_match "Connection refused", shell_output("#{bin}/pepper --saltapi-url=https://localhost:8000 --username='test' --password='fail' '*' test.ping 2>&1", 1)
  end
end
