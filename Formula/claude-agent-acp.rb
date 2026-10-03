class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.85.0.tgz"
  sha256 "443235d6ee4c4bc6f4b294824a55e01b84ef0472a190d294c28e96da7b501213"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.85.0"
    sha256                               arm64_tahoe:  "c6138a2cf74c74ac54956443418645882ab93cae3ad23a2f8ac4ad2da83c0a2c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "947da8738a1d8ec1db46b0fd5e1dbafa1f596a3afefd84a7cb4c35ae3b906612"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b807c40df67bbafa2d6d4f5959c20150956b011c3ee614885c8de21584257465"
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
