class Jsonschema < Formula
  include Language::Python::Virtualenv

  desc "Implementation of JSON Schema for Python"
  homepage "https://github.com/Julian/jsonschema"
    url "https://github.com/Julian/jsonschema.git",
      :revision => "5e0fea13189bf118eadc8c812eed08f0751b8394"
  version "3.2.99"
  head "https://github.com/Julian/jsonschema.git"

  depends_on "python@3.8"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz"
    sha256 "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72"
  end

  resource "more-itertools" do
    url "https://files.pythonhosted.org/packages/df/8c/c278395367a46c00d28036143fdc6583db8f98622b83875403f16473509b/more-itertools-8.1.0.tar.gz"
    sha256 "c468adec578380b6281a114cb8a5db34eb1116277da92d7c46f904f0b52d3288"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/90/aa/cdcf7ef88cc0f831b6f14c8c57318824c9de9913fe8de38e46a98c069a35/pyrsistent-0.15.7.tar.gz"
    sha256 "cdc7b5e3ed77bed61270a47d35434a30617b9becdf2478af76ad2c6ade307280"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/d4/cd/ef86396dce8910413b6ca1ef31ec09367c47e15fc1a12def2cc8ae134dea/zipp-1.0.0.tar.gz"
    sha256 "d38fbe01bbf7a3593a32bc35a9c4453c32bc42b98c377f9bff7e9f8da157786c"
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

    assert_match "SUCCESS", shell_output("#{bin}/jsonschema --output pretty --instance #{testpath}/test.json #{testpath}/test.schema")
  end
end
