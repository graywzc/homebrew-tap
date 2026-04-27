cask "ai-aggregator" do
  version "1.1.1"
  sha256 "e74836ed9d3018347e18255cbab99ff4a0b162d23e6df6e9544ba156cb42f53e"

  url "https://github.com/graywzc/ai-aggregator/releases/download/v#{version}/AIAggregator.zip"
  name "AI Aggregator"
  desc "macOS menu bar app to track AI usage limits"
  homepage "https://github.com/graywzc/ai-aggregator"

  app "AIAggregator.app"

  postflight do
    # 1. Quit the app if running
    system_command "/usr/bin/pkill", args: ["-x", "AIAggregator"], must_succeed: false

    # 2. Fix quarantine and signature
    system_command "xattr",
                   args: ["-cr", "#{appdir}/AIAggregator.app"],
                   sudo: false
    system_command "codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/AIAggregator.app"],
                   sudo: false

    # 3. Relaunch the app
    system_command "/usr/bin/open", args: ["#{appdir}/AIAggregator.app"], sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.graywzc.AIAggregator.plist",
    "~/Library/Saved Application State/com.graywzc.AIAggregator.savedState",
  ]
end