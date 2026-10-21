class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.94.0.tgz"
  sha256 "a162298ffb17b2a3d4f0d07d035e272b9d8e0dda939aa47abbcca61c87ce26a9"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.94.0"
    sha256                               arm64_tahoe:  "1aeef777cba0de38da6253384cd40a16516cc9d35e6cbe97978d5d93a573d75a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "83dbce15247b8511e65cd964e0028313e372e939c54cbaebef385282f8f7bd2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7c0d1307c4ed5a1b180c6a518e4c743f0fba4e488a002d1ad3201957b3f4f266"
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
