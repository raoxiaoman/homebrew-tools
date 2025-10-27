class Cleanold < Formula
  desc "Clean up old files by moving them to macOS Trash"
  homepage "https://github.com/raoxiaoman/cleanold"
  url "https://github.com/raoxiaoman/cleanold/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  def install
    bin.install "bin/cleanold"
  end

  test do
    system "#{bin}/cleanold", "-h"
  end
end
