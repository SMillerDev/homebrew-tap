class Jsonschema < Formula
  include Language::Python::Virtualenv

  desc "Implementation of JSON Schema for Python"
  homepage "https://github.com/Julian/jsonschema"
  url "https://files.pythonhosted.org/packages/ee/10/f2137346cd9568f1a92a9c6c12b086bc14223f16e90ab04d8c8edf36d39d/jsonschema-4.0.0a1.tar.gz"
  sha256 "6fbbcc8035b0d8722146b8a90ada08fcd910b731aa0c920b757be9c081bc849f"
  head "https://github.com/Julian/jsonschema.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/jsonschema-4.0.0a1"
    sha256 cellar: :any_skip_relocation, catalina:     "2984a54e22bc0744f7cab13d8df5a204f0831697ccef30ad1029f4be9f8ec7f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69b7e3fcee9ddd0097f67d7179a6a73d5f775568eb1e86a908a119281efabff9"
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
