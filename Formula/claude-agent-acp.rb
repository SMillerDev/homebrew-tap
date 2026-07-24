class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.61.0.tgz"
  sha256 "bb410d53e2d13591da5ebcaf09ae055d166ffefb27b7172988650cd62ef4ebd3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.60.0"
    sha256                               arm64_tahoe:  "92c909b6f790397fd1b0a1eb9dadff7f2aa002c1b785964e598c5f604be9a713"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "96bcc31efb8680fd7827547c21890a1d81333d92fc5e8c480285c76b1564bcda"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "68d4ee4d959404217f21e8e434d37705f73fafe153104be4d63a6861444e13a0"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid message", output
  end
end
