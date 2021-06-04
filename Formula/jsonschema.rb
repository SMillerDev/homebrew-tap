class Jsonschema < Formula
  include Language::Python::Virtualenv

  desc "Implementation of JSON Schema for Python"
  homepage "https://github.com/Julian/jsonschema"
  url "https://files.pythonhosted.org/packages/ee/10/f2137346cd9568f1a92a9c6c12b086bc14223f16e90ab04d8c8edf36d39d/jsonschema-4.0.0a1.tar.gz"
  sha256 "6fbbcc8035b0d8722146b8a90ada08fcd910b731aa0c920b757be9c081bc849f"
  head "https://github.com/Julian/jsonschema.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/jsonschema-3.2.99_1"
    sha256 cellar: :any_skip_relocation, catalina:     "1f61955fb9ba82b303eea7e9347ed9f6f1fd4cb72882bef417cfc38051946530"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "75d496f68f15c3c40b64fa767200820a54cb0caab2d688922b4af3a22e6bab97"
  end

  depends_on "python@3.9"
  depends_on "six"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/4d/70/fd441df751ba8b620e03fd2d2d9ca902103119616f0f6cc42e6405035062/pyrsistent-0.17.3.tar.gz"
    sha256 "2e636185d9eb976a18a8a8e96efce62f2905fea90041958d8cc2a189756ebf3e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.json").write <<~EOS
      {
      	"name" : "Eggs",
      	"price" : 34.99
      }
    EOS

    (testpath/"test.schema").write <<~EOS
      {
        "type": "object",
        "properties": {
            "price": {"type": "number"},
            "name": {"type": "string"}
        }
      }
    EOS

    out = shell_output("#{bin}/jsonschema --output pretty --instance #{testpath}/test.json #{testpath}/test.schema")
    assert_match "SUCCESS", out
  end
end
