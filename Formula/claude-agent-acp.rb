class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.79.0.tgz"
  sha256 "8c7a692b0266389eb7d81d4cb836c1f21293fb6a0ed11bff2e15db42c36177cb"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.79.0"
    sha256                               arm64_tahoe:  "5c37c8bb703ec5d1f6f06e6341f661eb5b57afdc1540758838c9628aa85aa4f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e7b3035abd4fb33fde7223eadaef8faface9bacc2add07f9b3fd638a44c14a7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1e54b072f267e65f1d8ec719e71e1329753e2155be71bf683a7af9d376d37ef"
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
