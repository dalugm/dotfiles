.tmux
=====

Installation
------------

Requirements:

  - awk, perl and sed
  - outside of tmux, `$TERM` must be set to `xterm-256color`


```
$ ln -sf $HOME/.tmux/tmux.conf ~/.tmux.conf
```

If you're a Vim user, setting the `$EDITOR` environment variable to `vim` will
enable and further customize the vi-style key bindings (see tmux manual).

If you're new to tmux, I recommend you read [tmux 2: Productive Mouse-Free
Development][bhtmux2] by [@bphogan].

[bhtmux2]: https://pragprog.com/book/bhtmux2/tmux-2
[@bphogan]: https://twitter.com/bphogan

Troubleshooting
---------------

 - **Status line is broken and/or gets duplicated at the bottom of the screen.
   What gives?**

   This particularly happens on Linux when the distribution provides a version
   of glib that received Unicode 9.0 upgrades (glib `>= 2.50.1`) while providing
   a version of glibc that didn't (glibc `< 2.26`). You may also configure
   `LC_CTYPE` to use an `UTF-8` locale. Typically VTE based terminal emulators
   rely on glib's `g_unichar_iswide()` function while tmux relies on glibc's
   `wcwidth()` function. When these two functions disagree, display gets messed
   up.

   This can also happen on macOS when using iTerm2 and "Use Unicode version 9
   character widths" is enabled in `Preferences... > Profiles > Text`

   For that reason, the default `~/.tmux.conf.local` file stopped using Unicode
   characters for which width changed in between Unicode 8.0 and 9.0 standards,
   as well as Emojis.

Features
--------

 - `C-a` acts as prefix, while rebounding default `C-b` prefix
 - [maximize any pane to a new window with `<prefix> +`][maximize-pane]
 - SSH/Mosh aware username and hostname status line information
 - mouse mode toggle with `<prefix> m`
 - automatic usage of [`reattach-to-user-namespace`][reattach-to-user-namespace]
   if available
 - laptop battery status line information
 - uptime status line information
 - optional highlight of focused pane (tmux `>= 2.1`)
 - configurable new windows and panes behavior (optionally retain current path)
 - SSH/Mosh aware split pane (reconnects to remote server)
 - copy to OS clipboard (needs [`reattach-to-user-namespace`][reattach-to-user-namespace]
   on macOS, `xsel` or `xclip` on Linux)
 - support for 4-digit hexadecimal Unicode characters (requires `perl` or Bash >= 4.1.2)

[maximize-pane]: http://pempek.net/articles/2013/04/14/maximizing-tmux-pane-new-window/
[reattach-to-user-namespace]: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard

The "maximize any pane to a new window with `<prefix> +`" feature is different
from builtin `resize-pane -Z` as it allows you to further split a maximized
pane. It's also more flexible by allowing you to maximize a pane to a new
window, then change window, then go back and the pane is still in maximized
state in its own window. You can then minimize a pane by using `<prefix> +`
either from the source window or the maximized window.

![Maximize pane](https://cloud.githubusercontent.com/assets/553208/9890858/ee3c0ca6-5c02-11e5-890e-05d825a46c92.gif)

Mouse mode allows you to set the active window, set the active pane, resize
panes and automatically switches to copy-mode to select text.

![Mouse mode](https://cloud.githubusercontent.com/assets/553208/9890797/8dffe542-5c02-11e5-9c06-a25b452e6fcc.gif)

Bindings
--------

tmux may be controlled from an attached client by using a key combination of a
prefix key, followed by a command key. This configuration uses `C-a` as a
secondary prefix while keeping `C-b` as the default prefix. In the following
list of key bindings:
  - `<prefix>` means you have to either hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>
  - `<prefix> c` means you have to hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd> followed by <kbd>c</kbd>
  - `<prefix> C-c` means you have to hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd> followed by <kbd>Ctrl</kbd> + <kbd>c</kbd>

This configuration uses the following bindings:

 - `<prefix> e` opens `~/.tmux.conf` with the editor defined by the
   `$EDITOR` environment variable (defaults to `vim` when empty)
 - `<prefix> r` reloads the configuration
 - `C-l` clears both the screen and the tmux history

 - `<prefix> C-c` creates a new session
 - `<prefix> C-f` lets you switch to another session by name

 - `<prefix> C-h` and `<prefix> C-l` let you navigate windows (default
   `<prefix> n` and `<prefix> p` are unbound)
 - `<prefix> Tab` brings you to the last active window

 - `<prefix> -` splits the current pane vertically
 - `<prefix> _` splits the current pane horizontally
 - `<prefix> h`, `<prefix> j`, `<prefix> k` and `<prefix> l` let you navigate
   panes ala Vim
 - `<prefix> H`, `<prefix> J`, `<prefix> K`, `<prefix> L` let you resize panes
 - `<prefix> <` and `<prefix> >` let you swap panes
 - `<prefix> +` maximizes the current pane to a new window

 - `<prefix> m` toggles mouse mode on or off

 - `<prefix> Enter` enters copy-mode
 - `<prefix> b` lists the paste-buffers
 - `<prefix> p` pastes from the top paste-buffer
 - `<prefix> P` lets you choose the paste-buffer to paste from

Configuration
-------------

While this configuration tries to bring sane default settings, you may want to
customize it further to your needs.

### Accessing the macOS clipboard from within tmux sessions

[Chris Johnsen created the `reattach-to-user-namespace`
utility][reattach-to-user-namespace] that makes `pbcopy` and `pbpaste` work
again within tmux.

To install `reattach-to-user-namespace`, use either [MacPorts][] or
[Homebrew][]:

    $ port install tmux-pasteboard

or

    $ brew install reattach-to-user-namespace

Once installed, `reattach-to-usernamespace` will be automatically detected.

[MacPorts]: http://www.macports.org/
[Homebrew]: http://brew.sh/

### Using the configuration under Cygwin within Mintty

**I don't recommend running this configuration with Cygwin anymore. Forking
under Cygwin is extremely slow and this configuration issues a lot of
`run-shell` commands under the hood. As such, you will experience high CPU
usage. As an alternative consider using [Mintty terminal for WSL][wsltty].**

![cygwin](https://cloud.githubusercontent.com/assets/553208/19741789/67a3f3d8-9bc2-11e6-9ecc-499fc0228ee6.png)

It is possible to use this configuration under Cygwin within Mintty, however
support for Unicode symbols and emojis lacks behind Mac and Linux.

Particularly, Mintty's text rendering is implemented with GDI which has
limitations:

- color emojis are only available through DirectWrite starting with Windows 8.1
- display of double width symbols, like the battery discharging symbol indicator
  (U+1F50B) is buggy

To get Unicode symbols displayed properly, you have to use [font linking].
Open `regedit.exe` then navigate to the registry key at
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`
and add a new entry for you preferred font to link it with the Segoe UI Symbol
font.

![regedit](https://cloud.githubusercontent.com/assets/553208/19741304/71a2f3ae-9bc0-11e6-96aa-4c09a812c313.png)

[font linking]: https://msdn.microsoft.com/en-us/goglobal/bb688134.aspx
