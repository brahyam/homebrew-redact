# homebrew-redact

The Homebrew tap for [REDACT](https://useredact.com) — a Mac meeting recorder
that transcribes the call and writes the notes on your own machine.

```sh
brew install --cask brahyam/redact/redact
```

One command, cold — it taps on the way. Spell the tap out like that rather than
`brew tap` first: since Homebrew 6, `brew tap` on a third-party tap stops and
tells you to run `brew trust`, and a fully-qualified install skips that detour.

Then launch REDACT from Applications. On first run it downloads the models it
transcribes and writes with (about 2.4 GB, once); after that it needs no
network at all.

Apple Silicon, macOS 13 Ventura or later. The call's own audio needs macOS
14.2+; below that you get a mic-only recording.

## Updating

REDACT updates itself, so `brew upgrade` is not how you get a new version —
the cask is marked `auto_updates true` and exists to install it the first time.

## How this tap is maintained

`Casks/redact.rb` is bumped automatically by `scripts/release.sh` in the
(private) app repo, as part of `make release`: it pushes the GitHub release
first, then rewrites `version` and `sha256` here from the DMG it just signed and
notarized. Nothing is hand-edited. If the cask's version trails the latest
release, that bump step failed — it is deliberately best-effort so it cannot
fail a release — and re-running it is the fix.

The DMG it points at is signed with a Developer ID certificate and notarized by
Apple.
