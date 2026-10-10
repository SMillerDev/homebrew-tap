class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.88.0.tgz"
  sha256 "5655e1ed94efbc2f05ee0d34a26d98697245946250b334f7e009debe14e5fba6"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.87.0"
    sha256                               arm64_tahoe:  "aa9b768d3551b81507ed92f381bd41a2eaa241beb9f63c3b1ed94ccc73d52da9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "74d2e75f32895b0723477aeb198fc4cb6ba4f251a33608c05d5bab62777d8258"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8c133cb64177e5e3520b2156cb080b3bf9e0de7ed118bc2734b28fe26c149669"
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
