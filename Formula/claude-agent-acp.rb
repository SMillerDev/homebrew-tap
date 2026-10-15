class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.90.0.tgz"
  sha256 "fb5538b0b433f7ec1b8dfde7c78e9197f8e9784f2407e3ff4f627436e386f66a"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.90.0"
    sha256                               arm64_tahoe:  "339a5c3198760b84fe931b78006b9c7a59fe754e1fa4816394270f9e1d8a0a1d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "213e229bf151c31b3608dd5b22cdcbcd8d56bd2d54c5c36fe31f5684c91cd9b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5a487f4a5d6448c72e85cc044f40e08d1ef2cfef631ee52f31b90931e375b7c9"
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
