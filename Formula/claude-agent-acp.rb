class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.94.0.tgz"
  sha256 "a162298ffb17b2a3d4f0d07d035e272b9d8e0dda939aa47abbcca61c87ce26a9"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.93.0"
    sha256                               arm64_tahoe:  "dfcdda7e40f2370c5bf83953c97048e012bd7bda891a6e1bbb3b5c2b3826a6f4"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c9d1c78583231e33303b723eb9406b25256ee0ba70d60c4c434ae2b4be066b2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fc5138d438a7e12db0d0c1361263875e0e488f51c2deed42f4a285846d69077a"
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
