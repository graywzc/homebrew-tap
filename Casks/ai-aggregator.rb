cask "ai-aggregator" do
  version "1.3.1"
  sha256 "9f3fd5bf81e1be1d16867f47206bdbb60a9981e32792ff02efd174a1e6755a15"

  url "https://github.com/graywzc/ai-aggregator/releases/download/v#{version}/AIAggregator.zip"
  name "AI Aggregator"
  desc "Menu bar app to track AI usage limits"
  homepage "https://github.com/graywzc/ai-aggregator"

  depends_on macos: :ventura

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
