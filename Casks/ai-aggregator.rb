cask "ai-aggregator" do
  version "1.0.6"
  sha256 "294f2203b7aecdda9db43203f1df4db54c747e9ace2e63b75b17c96457a230f4"

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