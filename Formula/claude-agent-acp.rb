class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.57.0.tgz"
  sha256 "6aec8cf55fcb01e0dbb6bac7b5e600e76eefc200612487efbcf06a5d00a38e4c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.56.0"
    sha256                               arm64_tahoe:  "5a7d34d5d483a8ebf8b66fb7da4c6ba2f486a5dc45c622901c5ffef5756f72f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a312175c05e754167f15a79754d8b4773eaec1778d68ce82c899801e0d097c3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1049acedb4a7f76baf1a17d4a713c90d5384adf2986ddaaade1002fc214040c4"
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
