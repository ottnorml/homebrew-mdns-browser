cask "mdns-browser" do
  version "1.4.1"
  # see https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg.sha256
  sha256 "f46e01c335ebed1352dcc06b60a6ddf5706b6bff427da2b04d208c52b9257332"

  url "https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg"
  name "mDNS-Browser"
  desc "Cross platform app written in Rust using Tauri and Leptos"
  homepage "https://github.com/hrzlgnm/mdns-browser"

  livecheck do
    url :url
    regex(/^mdns-browser-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :monterey"

  app "mdns-browser.app"
  binary "#{appdir}/mdns-browser.app/Contents/MacOS/mdns-browser"

  zap trash: [
    "~/Library/Caches/com.github.hrzlgnm.mdns-browser",
    "~/Library/Logs/com.github.hrzlgnm.mdns-browser",
    "~/Library/WebKit/com.github.hrzlgnm.mdns-browser",
  ]
end
