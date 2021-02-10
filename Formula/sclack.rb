# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Sclack < Formula
  include Language::Python::Virtualenv

  desc ""
  homepage ""
  url "https://github.com/haskellcamargo/sclack/archive/master.tar.gz"
  version "0.0.1"
  sha256 "dd5f51b649780c1ba68b314670e2be06a82faf6ab39ef8ccd8c03f6b328f0583"
  license "GPL-3.0"

  depends_on "pipenv"
  depends_on "python@3.7"



  resource "asyncio" do
    url "https://files.pythonhosted.org/packages/da/54/054bafaf2c0fb8473d423743e191fcdf49b2c1fd5e9af3524efbe097bafd/asyncio-3.4.3.tar.gz"
    sha256 "83360ff8bc97980e4ff25c964c7bd3923d333d177aa4f7fb736b019f26c7cb41"
  end

  resource "urwid" do
    url "https://files.pythonhosted.org/packages/45/dd/d57924f77b0914f8a61c81222647888fbb583f89168a376ffeb5613b02a6/urwid-2.1.0.tar.gz"
    sha256 "0896f36060beb6bf3801cb554303fef336a79661401797551ba106d23ab4cd86"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/6f/4c/0b1d507ad7e8bc31d690d04b4f475e74c2002d060f7994ce8c09612df707/pyperclip-1.8.1.tar.gz"
    sha256 "9abef1e79ce635eb62309ecae02dfb5a3eb952fa7d6dce09c1aef063f81424d3"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/6b/47/c14abc08432ab22dc18b9892252efaf005ab44066de871e72a38d6af464b/requests-2.25.1.tar.gz"
    sha256 "27973dd4a904a4f13b263a19c866c13b92a39ed1c964655f025f3f8d3d75b804"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/c9/bb/8d3dd9063cfe0cd5d03fe6a1f74ddd948f384e9c1eff0eb978f3976a7d27/websocket_client-0.47.0.tar.gz"
    sha256 "a453dc4dfa6e0db3d8fd7738a308a88effe6240c59f3226eb93e8f020c216149"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/d7/8d/7ee68c6b48e1ec8d41198f694ecdc15f7596356f2ff8e6b1420300cf5db3/urllib3-1.26.3.tar.gz"
    sha256 "de3eedaad74a2683334e282005cd8d7f22f4d55fa690a2a1020a416cb0a47e73"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
    sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/06/a9/cd1fd8ee13f73a4d4f491ee219deeeae20afefa914dfb4c130cfc9dc397a/certifi-2020.12.5.tar.gz"
    sha256 "1a4995114262bffbc2413b159f2a1a480c969de6e6eb13ee966d470af86af59c"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "urwid_readline" do
    url "https://files.pythonhosted.org/packages/ce/77/0bd776401bccc07dd6b5e8543a9e218ee8c06f642c8dd8f4c6063d7294cb/urwid_readline-0.12.tar.gz"
    sha256 "f7384e03017c3fb07bfba0d829d70287793326d9f6dac145dd09e0d693d7bf9c"
  end

  resource "slackclient" do
    url "https://files.pythonhosted.org/packages/1f/9e/dd5bb327786be753e5d8de976082eb714cb83abeb00f67f0646ba2e166ad/slackclient-1.2.1.tar.gz"
    sha256 "e9de0c893e8c5473107f5927ae1e543d35246f0c834f5e86470b22b762211577"
  end

  resource "six" do
  	url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
  	sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  def install
    venv = virtualenv_create(libexec, "python3.7")
    venv.pip_install resources
    venv.pip_install buildpath
    bin.install_symlink "#{libexec}/bin/app.py" => "sclack"
  end

  test do
    system "sclack"
  end
end
