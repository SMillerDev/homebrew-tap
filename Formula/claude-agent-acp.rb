class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.56.0.tgz"
  sha256 "e44ba8a559135bcc73f1ce65b2c0b48ce5b916786cf21a96149aeb6a7b77ab1c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.55.0"
    sha256                               arm64_tahoe:  "d26e9edc98382497f13db1219425d574f97829c1a5f98cce91e82ab03b218636"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "40d59c50fe6e4ead743b3165980b737022b5dbe63e5cf5855255b64e7ca1ab0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c68c0a3ebc6484a75bc0af47229cb33fbff1b5868dc14ac9c2462207718f71d8"
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
