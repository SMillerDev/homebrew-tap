class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.60.0.tgz"
  sha256 "1473f842bdf097bf3f083b26128640f3a055aa5684d6bf57e4433c83de730ec7"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.57.0"
    sha256                               arm64_tahoe:  "0052636d53fa8d2037d122bbb9beae3839d667d19d65fbc8f220abb9c0cb3464"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "725409eee38d875087f892964bae0162c927bdf6ec321acc85c1a0da923ea1fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f08cf0f62ffa7ad0a8955214568a494bae4dd5b360a49f59f49f541ac3acb4f2"
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
