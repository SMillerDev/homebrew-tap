class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.84.0.tgz"
  sha256 "aad0a1e7acaf7e8526ce339b2fd8187ecc9da2d5f9471de284908a105dc89626"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.81.2"
    sha256                               arm64_tahoe:  "5325868cb775e4e9c3731cca06fff5525bbf107ab632245c51a74e974e7cf062"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "b5b156944e1049a4f07af29d432bba8e84c0ea6e16f13e07aeee35a7dc03b8a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98be2232961f5679b528149a96fe9e30e95f022c0d75448d96be8d729de73845"
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
