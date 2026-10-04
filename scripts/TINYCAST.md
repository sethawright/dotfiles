# Tinycast setup

Tinycast's portable configuration is in `tinycast/` in the private
[dot-files-private](https://github.com/sethawright/dot-files-private) repo. Your public dotfiles
`setup_mac.sh` authenticates GitHub and restores it automatically through
`scripts/tinycast-config setup`.

On a fresh Mac, clone `sethawright/dotfiles` to `~/dotfiles` and run its setup.
The private checkout is cloned to `~/work/dot-files-private`. Override that
location with `DOTFILES_PRIVATE_DIR` if needed. The GitHub account must have
access to this private repo.

## Save changes from either Mac

Run **Quit Tinycast** in the launcher (closing the window is not quitting), then run:

```sh
~/dotfiles/scripts/tinycast-config save
```

This fetches the current snapshot first, saves this Mac's portable configuration,
commits it, and pushes it here. Reopen Tinycast afterward.

## Apply changes on the other Mac

Run **Quit Tinycast** in the launcher (closing the window is not quitting), then run:

```sh
~/dotfiles/scripts/tinycast-config restore
```

This pulls the latest snapshot, backs up the configuration being replaced under
`~/Library/Application Support/Tinycast-config-backups/`, and restores it.
Reopen Tinycast afterward. Restore chooses the saved snapshot; it does not merge
simultaneous edits from two Macs. Save from the source Mac, then restore on the
other before editing there. Git conflicts/diverged branches stop the command.

Setup restores once. Re-running machine setup preserves later local changes.
Configuration is shared through these commands, not a background sync service.

## Included

- Portable settings and hotkeys, aliases, favorites, hidden commands and layouts
- Snippets and quicklinks (including a consistent SQLite snapshot)
- Compiled extension commands, manifests and assets
- Extension command metadata, appearance and version metadata when present

Home paths in preferences and quicklinks are adapted to the destination Mac.
The explicit preference allowlist lives in the public `tinycast-config` script;
new Tinycast preference keys need to be reviewed and added there.

## Kept on each Mac

Account sign-ins, Keychain credentials, API keys, extension preference/storage
secrets, permissions, clipboard/history databases, notes and runtime caches.
Set up those sign-ins and macOS permissions once on each Mac. Machine-specific
preferences are preserved when restoring the portable snapshot.

## Recovering a previous configuration

Quit Tinycast. Each backup contains the replaced portable files and a complete
`preferences.plist`. Move the files back into
`~/Library/Application Support/com.tinycast.app/` and import preferences using:

```sh
defaults import com.tinycast.app /path/to/backup/preferences.plist
```

Reopen Tinycast. Keep this repo private: snippets and quicklinks are personal.
