class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.100.0.tgz"
  sha256 "bb1de8a11cb585a4e8da2fd1a0252aa613ac9cd2cdc47a23247c9847c6d132b8"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.100.0"
    sha256                               arm64_tahoe:  "a724022502c7a01b6c7cb94334c846e3c39aa0a08705d5bfa5d66c15fb634f03"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ff655543c74f7532faa5a2d3645c3c1d60a42a1f308b6a95aaf2b375df4bbb16"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "44be2957169ed75c44595575dada5fbec5afcfad9d993384983467bbf6d54cf9"
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
