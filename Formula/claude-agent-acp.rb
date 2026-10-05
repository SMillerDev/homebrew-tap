class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.85.1.tgz"
  sha256 "d978cbaa5a97ef5e70b5f7b303089f5289fa54f84b7ff2685b84436378566d3a"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.85.1"
    sha256                               arm64_tahoe:  "7db81b5c36b5425add158c0c7850e3618cec17b1a967f573d8a61e2d35227771"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0f9a9f0c616196900150add5ee310fe7882730533bf8c4b899a861f47417173b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9d144f3d0470c934dff6291dab7aa81607941e6f5802bb8b2b83cff16d9c8535"
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
