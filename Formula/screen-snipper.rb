class ScreenSnipper < Formula
  desc "Tiny macOS screen-region recorder for GIFs and MP4 video"
  homepage "https://github.com/graywzc/screen-snipper"
  url "https://github.com/graywzc/screen-snipper/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7c0d1347cf0daff6f8c9816ca2f52fcc4683b0dd156ce1df9ef86dbb3b8b9b29"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/screen-snipper"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/screen-snipper --help")
  end
end
