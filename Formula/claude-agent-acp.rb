class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.78.0.tgz"
  sha256 "6ee5e95b94fd9a3523f94d84b476737e6583f5a35394cfa8423194092dd501c3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.78.0"
    sha256                               arm64_tahoe:  "643858dc82dd306019eb9d35330e4116c75b23c6657272237d409bc16fd36b59"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9397208ae7ac7425cb18c2a9ce1c39c8a0e065a279a0247b48d8d977fcf9141d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "97fbb9b1247cfb9af2f2f665f1f4bf1802a6cb36de563dd395447f7c48c83f7e"
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
