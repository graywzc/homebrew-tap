class ScreenSnipper < Formula
  desc "Tiny macOS screen-region recorder for GIFs and MP4 video"
  homepage "https://github.com/graywzc/screen-snipper"
  url "https://github.com/graywzc/screen-snipper/releases/download/v0.1.9/screen-snipper-0.1.9-macos.tar.gz"
  sha256 "7fc0adb60a8769cc7deebd1f1ee5b536ca267fda7c4da7a1756772f544d897ff"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    bin.install "screen-snipper"
    pkgshare.install "ScreenSnipper.shortcut"
  end

  def caveats
    <<~EOS
      To import the bundled macOS Shortcut named "ScreenSnipper", run:
        open #{opt_pkgshare}/ScreenSnipper.shortcut
      and click "Add Shortcut" in the Shortcuts.app dialog.

      To trigger it with a hotkey:
        1. Open Shortcuts.app
        2. Select "ScreenSnipper"
        3. Open the details panel (i icon)
        4. Click "Add Keyboard Shortcut" and press your combo (e.g. Cmd-Shift-7)

      While ScreenSnipper is open:
        Cmd-Shift-Space  start/stop recording
        Cmd-Shift-M      jump the capture area to the next monitor
        Cmd-Shift-7      close the app
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/screen-snipper --help")
  end
end
