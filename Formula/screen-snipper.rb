class ScreenSnipper < Formula
  desc "Tiny macOS screen-region recorder for GIFs and MP4 video"
  homepage "https://github.com/graywzc/screen-snipper"
  url "https://github.com/graywzc/screen-snipper/releases/download/v0.1.3/screen-snipper-0.1.3-macos.tar.gz"
  sha256 "1b0f8cd5d19d47c3c5b19b7164c7ed3001b07bad7354f365e1c4d49e155d245d"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    bin.install "screen-snipper"
    pkgshare.install "ScreenSnipper.shortcut"
  end

  def post_install
    shortcut = pkgshare/"ScreenSnipper.shortcut"
    return unless shortcut.exist?

    if File.executable?("/usr/bin/shortcuts")
      existing = Utils.safe_popen_read("/usr/bin/shortcuts", "list").lines.map(&:strip)
      return if existing.include?("Screen Snipper")
    end

    system "open", shortcut.to_s
  end

  def caveats
    <<~EOS
      A macOS Shortcut named "Screen Snipper" was opened for import. Click
      "Add Shortcut" in the Shortcuts.app dialog if it appeared.

      To trigger it with a hotkey:
        1. Open Shortcuts.app
        2. Select "Screen Snipper"
        3. Open the details panel (i icon)
        4. Click "Add Keyboard Shortcut" and press your combo (e.g. Cmd-Shift-7)

      While Screen Snipper is open:
        Cmd-Shift-Space  start/stop recording
        Cmd-Shift-7      close the app
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/screen-snipper --help")
  end
end
