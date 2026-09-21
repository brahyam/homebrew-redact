cask "redact" do
  version "0.16.0"
  sha256 "0660745595827ddfd4832f56daf9b75a5355339c7fa08fcfedef9a61f3f86e4f"

  url "https://github.com/brahyam/useredact-releases/releases/download/v#{version}/REDACT_#{version}_aarch64.dmg"
  name "REDACT"
  desc "Meeting recorder that transcribes calls and writes the notes on-device"
  homepage "https://useredact.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # REDACT ships a Tauri updater and updates itself in place, so the version
  # pinned above goes stale between release bumps by design. Without this,
  # `brew outdated` reports every self-updated install as broken.
  auto_updates true
  # Apple Silicon only (Metal, Core Audio process tap, cidre). Ventura is the
  # floor; the call's own audio needs 14.2 and degrades to a mic-only recording
  # below it, which is a runtime fallback rather than an install-time gate.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "REDACT.app"

  # Everything the app writes. `com.redact.app` is the pre-pivot bundle id
  # (0.9.x installs on the frozen channel) — listed so a zap after an upgrade
  # does not leave the old tree behind.
  zap trash: [
    "~/Library/Application Support/com.redact.app",
    "~/Library/Application Support/com.useredact.app",
    "~/Library/Caches/com.redact.app",
    "~/Library/Caches/com.useredact.app",
    "~/Library/HTTPStorages/com.useredact.app",
    "~/Library/Preferences/com.redact.app.plist",
    "~/Library/Preferences/com.useredact.app.plist",
    "~/Library/Saved Application State/com.useredact.app.savedState",
    "~/Library/WebKit/com.useredact.app",
  ]
end
