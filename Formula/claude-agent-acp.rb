class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.63.0.tgz"
  sha256 "524c62960928c3c2d9b97db5ed14c2823575b333b9ce0d4c42973652c30b26a2"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.62.0"
    sha256                               arm64_tahoe:  "3621386e72cd201718e9bb57061d1b47d8aa45bb5a9bc8d494e76bd90417fe4f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "75acb0cf958a54832b12528ef1b9923e10836b904b27b203a08543ce67864269"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fa1b7969a74b845be323068bc9d4ddbf3029d94a39de1460be225677c1c1c97"
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
