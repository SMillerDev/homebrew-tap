class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.68.0.tgz"
  sha256 "6fb5039bcbcd0422a80809432871fc837d6164be1a3386dece323cfc39171afa"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.66.0"
    sha256                               arm64_tahoe:  "795269dab90464efd9089ff45dd7f89841854ffc4b3954e083271a06384402b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a2470e86e1632b07922b0d4095f473a668c64dc10e19ebe974ec06c0dd58b898"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c3c6d71f979ebf9e088fc9c4f090989bcab2f3268d9f880e551d8b6529f7bd1"
  end

  depends_on "homebrew/core/node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid message", output
  end
end
