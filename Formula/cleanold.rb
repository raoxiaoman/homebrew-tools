class Cleanold < Formula
  desc "Clean up old files by moving them to macOS Trash"
  homepage "https://github.com/raoxiaoman/cleanold"
  url "https://github.com/raoxiaoman/cleanold/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT"

  def install
    bin.install "bin/cleanold"
  end

  test do
    system "#{bin}/cleanold", "-h"
  end
end
