cask "mdns-browser" do
  version "0.23.1"
  # see https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg.sha256
  sha256 "29d6f89eb3263cb1bacc9042ba6a98e27721fc0acb156dd7b2e47d3634864f8e"

  url "https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg"
  name "mDNS-Browser"
  desc "Graphical discovery, inspection and testing tool for mDNS services"
  homepage "https://github.com/hrzlgnm/mdns-browser"

  livecheck do
    url :url
    regex(/^mdns-browser[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :high_sierra"

  app "mdns-browser.app"
  binary "#{appdir}/mdns-browser.app/Contents/MacOS/mdns-browser"

  zap trash: [
    "~/Library/Caches/com.github.hrzlgnm.mdns-browser",
    "~/Library/Logs/com.github.hrzlgnm.mdns-browser",
    "~/Library/WebKit/com.github.hrzlgnm.mdns-browser",
  ]
end
