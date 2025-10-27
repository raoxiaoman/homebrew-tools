class Cleanold < Formula
  desc "Clean up old files by moving them to macOS Trash"
  homepage "https://github.com/raoxiaoman/homebrew-tools"
  url "https://github.com/raoxiaoman/homebrew-tools/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "9457dc8fccd56f6830ae1f492d568aff2d263b5bdaa7bd73a7c3ed0a962ca41c"
  license "MIT"

  def install
    bin.install "bin/cleanold"
  end

  test do
    system "#{bin}/cleanold", "-h"
  end
end
