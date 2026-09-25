class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.81.1.tgz"
  sha256 "60326dd11884e968259bd9e3650ec60980d6507a18d1c58d3d9b447d3b8069e6"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.80.0"
    sha256                               arm64_tahoe:  "7d253ceb2aa47e7edf748bd22b5e22430e6c91b9fcf815081e5e647ed4d60630"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "40818b21924456a96c893e50e0ad24951421bb39002c05dc38ed6d597fbab9d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2cde14e372d908cd7dc467a3c4ff45bd04249b6ccaef9de739399168d8824b9b"
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
