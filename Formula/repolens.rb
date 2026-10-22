class Repolens < Formula
  desc "Understand a repository's stack, services, env vars and setup problems"
  homepage "https://github.com/Douglas-Strey/repolens-cli"
  url "https://registry.npmjs.org/@douglas-strey/repolens/-/repolens-0.4.0.tgz"
  sha256 "c6ffc0a0dfe3bc5a816558d759d650572a3b3133541444604b76fa218fa09e22"
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
