class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.77.0.tgz"
  sha256 "040871730a084d5da591fff441d51628fb14e6842021aea53d5b5d6923eac508"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.76.0"
    sha256                               arm64_tahoe:  "86ba05d2dbeb66cc3facc7113fdcfd8d2cf1df87d69f25bfc9039ec148b723a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "68f13f10f1c487e6d0ba146c9fa47ac0a37e3277623acb4312500672cabb0e9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6521449beaff2f6f67a992c86d8dd3cbd407b276e2660f24b263860c40721c4d"
  end

  depends_on "homebrew/core/node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid request", output
  end
end
