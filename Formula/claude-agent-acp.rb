class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.87.0.tgz"
  sha256 "4c21b1168754fdb5343cf4a4f1661ece28a5d518d3d7738a6d92988855dd4705"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.86.0"
    sha256                               arm64_tahoe:  "18fbace9cb506081c8edd8289e1558aad890839155856fff100dcf05e919329f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3e7d6f425e3af73b83e196b8a145e999200d795b2decb64412f6b23b1a8fdbc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8fc5330f950f938129c6b1563bbb06b3824000d2fb540ee966705c8df842de22"
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
