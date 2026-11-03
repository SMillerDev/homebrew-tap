class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.99.1.tgz"
  sha256 "18629662c6940585ee2344329a7f46faf9ab1419de998a6a4f94c5224ae65f5c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.99.1"
    sha256                               arm64_tahoe:  "7ac40c2eb74a37d694b710cef145f69e66bdb4f44dbfb8b61e0b493a392f72d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9d234834c7a4dc28b38709546b3e6012814b79865f1b8b4dd9e2c55ce96faf6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1974e55d9fee49c351e359a94febfca963886d612af255f1ea2801a08ba28599"
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
