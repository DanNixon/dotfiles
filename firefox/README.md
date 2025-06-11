# Firefox

While I would *love* to have Firefox just configure itself and not have to do this manually, there does not exist a good way to do so.
Policies kind of get partially there, but are missing some settings that I would need.
I am also pretty sure trying to do anyting smarter than manual configuration would fail the [is it worth the time?](https://xkcd.com/1205/) test.

## Configuration steps

1. New Tab page
   - Disable *Sponsored shortcuts*
   - Disable *Recommended stories*
   - Disable *Sponsored stories*
2. Bookmarks Toolbar
   - Set to *Never Show*
3. Install the following addons, allowing them to run in private windows:
   - [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader)
   - [Decentraleyes](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes)
   - [Privacy Badger](https://privacybadger.org)
   - [Tridactyl](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim)
   - [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
4. Tridactyl
   - Open a new tab and allow the request to change the new tab page
   - Load colour scheme: `:colourscheme --url https://raw.githubusercontent.com/DanNixon/dotfiles/main/firefox/tridactyl/base16-monokai.css base16-monokai`
   - Load config: `:source --url https://raw.githubusercontent.com/DanNixon/dotfiles/main/firefox/tridactyl/tridactylrc`
   - Open a new tab and check that colour scheme and config are loaded and correct
5. Install [Multi Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers), not allowing it to run in normal windows
   - Complete setup panels: no sync, no Mozilla VPN
   - Delete default containers via Tridactyl `containerdelete`: "Personal", "Work", "Banking", "Shopping"
6. Set plugin icon visibility
   - Pinned to toolbar: Dark Reader
   - Everything else in extensions menu
7. Customize Toolbar
   - Remove:
      - Padding around omnibox
      - Pocket icon
      - Account icon
   - Right of omnibox: Downloads, Dark Reader, Extensions
8. *Settings* > *General*
   - Disable *picture in picture video controls*
9. *Settings* > *Search*
   - Set default to *DuckDuckGo*
10. *Settings* > *Privacy & Security*
   - Enable no data sharing and no tracking under *Web Site Privacy Preferences*
   - Disable *Ask to save passwords*
   - Disable *Autofill*
   - Enable *HTTPS-Only Mode in all windows*
11. Optionally, or as required, install the following plugins:
   - [Image Search Options](https://addons.mozilla.org/en-US/firefox/addon/image-search-options/)
   - [Redirector](https://addons.mozilla.org/en-US/firefox/addon/redirector/)
   - [Wallabagger](https://addons.mozilla.org/en-US/firefox/addon/wallabagger/)
