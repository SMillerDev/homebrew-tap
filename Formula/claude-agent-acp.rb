class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.93.0.tgz"
  sha256 "1273416aa828baad68e226f3992241e178608e692018d1e3446cbbd324deecac"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.91.0"
    sha256                               arm64_tahoe:  "121240adaf2110168d90fdd62d2062a1a3d5cea7f8185a82dbc7879de02e1aac"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6bcf9170551e9ffcbb3f6ee6e94239b901e9c0b1b0af8325b44935228e522d7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1ddedc96d891e2859cff9b9ee1ee3b50e1b6f5d32d02559918a88f2fb4a8912d"
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
