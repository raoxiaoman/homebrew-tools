class Cleanold < Formula
  desc "Clean up old files by moving them to macOS Trash"
  homepage "https://github.com/raoxiaoman/homebrew-tools"
  url "https://github.com/raoxiaoman/cleanold/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "5dd15471637e9c59ea2eead529cb590663f83bd18126f5f32626daae84e4a76c"
  license "MIT"

  def install
    bin.install "bin/cleanold"
  end

  test do
    system "#{bin}/cleanold", "-h"
  end
end
