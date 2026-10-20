class Repolens < Formula
  desc "Understand a repository's stack, services, env vars and setup problems"
  homepage "https://github.com/Douglas-Strey/repolens-cli"
  url "https://registry.npmjs.org/@douglas-strey/repolens/-/repolens-0.1.0.tgz"
  sha256 "1e2f1654e5475dd62fa2951b267cb042b1ef0ae4ccfb705fa397c2adfe2119ff"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/repolens --version")

    (testpath/"package.json").write <<~JSON
      { "name": "brew-test", "packageManager": "pnpm@10.17.1", "scripts": { "dev": "vite" } }
    JSON
    output = shell_output("#{bin}/repolens --json #{testpath}")
    assert_match '"name": "brew-test"', output
    assert_match '"run": "pnpm dev"', output
  end
end
