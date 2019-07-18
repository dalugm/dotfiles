;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(rust
     go
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     git
     lua
     tern
     yaml
     markdown
     prettier
     vimscript
     themes-megapack
     (helm :variables
           helm-use-fuzzy 'source
           )
     (neotree :variables
              neo-theme 'nerd
              )
     (chinese :variables
              chinese-enable-youdao-dict t
              )
     (latex :variables
            latex-enable-magic t
            )
     (spell-checking :variables
                     ;; Toggle it by `SPC t S'
                     spell-checking-enable-by-default nil
                     )
     (version-control :variables
                      version-control-diff-tool 'diff-hl
                      version-control-diff-side 'right
                      )
     (syntax-checking :variables
                      ;; Toggle it by `SPC t s'
                      syntax-checking-enable-by-default nil
                      )
     (auto-completion :variables
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-return-key-behavior 'complete
                      auto-completion-enable-sort-by-usage nil
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-private-snippets-directory nil
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      )
     (better-defaults :variables
                      better-defaults-move-to-end-of-code-first t
                      better-defaults-move-to-beginning-of-code-first t
                      )
     (multiple-cursors :variables
                       multiple-cursors-backend 'evil-mc)
     (html :variables
           web-fmt-tool 'prettier
           )
     (emacs-lisp :variables
                 ;; Nameless hides package namespaces in emacs-lisp code,
                 ;; and replaces it by leading `> It can be toggled with
                 ;; `SPC m T n'
                 ;; emacs-lisp-hide-namespace-prefix t
                 )
     (c-c++ :variables
            c-c++-enable-clang-support t
            c-c++-default-mode-for-headers 'c++-mode
            )
     (python :variables
             python-backend 'anaconda
             )
     (javascript :variables
                 javascript-backend 'tern
                 javascript-fmt-tool 'web-beautify
                 )
     (org :variables
          org-enable-github-support t
          org-enable-bootstrap-support t
          org-enable-org-journal-support t
          org-projectile-file "TODOs.org"
          )
     (shell :variables
            shell-default-height 30
            shell-default-shell 'eshell
            shell-default-position 'right
            )
     (colors :variables
             ;;colors-colorize-identifiers 'all
             ;; when in terminal, nyan cat will be ascii animations
             colors-enable-nyan-cat-progress-bar t
             ;; enable nyan cat only in a gui
             ;; colors-enable-nyan-cat-progress-bar (display-graphic-p)
             )
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     highlight-indent-guides
     ns-auto-titlebar
     )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'lisp-interaction-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   ;; ================================================================
   ;; =            dark -----------------------> light               =
   ;; =                     (Level in order)                         =
   ;; ================================================================
   dotspacemacs-themes
   '(
     dracula
     spacemacs-dark
     tao-yin
     sanityinc-tomorrow-night
     kaolin-aurora
     kaolin-ocean
     moe-dark
     monokai
     material
     solarized-dark
     sanityinc-tomorrow-blue
     tao-yang
     material-light
     sanityinc-tomorrow-day
     leuven
     spacemacs-light
     moe-light
     solarized-light
     )

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator slant :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 14
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 5

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers `(:relative t
                                         :disabled-for-modes
                                         dired-mode
                                         doc-view-mode
                                         markdown-mode
                                         pdf-view-mode
                                         )

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%a@%U"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;;==================================================================;;
  ;; Uncomment this if want to use mirror websites
  ;; to get faster speed to update packages
  ;;==================================================================;;
  (setq configuration-layer-elpa-archives
        '(
          ;; emacs-china
          ;;("melpa-cn" . "https://elpa.emacs-china.org/melpa/")
          ;;("org-cn"   . "https://elpa.emacs-china.org/org/")
          ;;("gnu-cn"   . "https://elpa.emacs-china.org/gnu/")

          ;; tuna
          ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
          )
        )
  ;;==================================================================;;
  (setq user-full-name "mutong"
        user-mail-address "moutong945@gmail.com"
        )
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;;========================================================
  ;;                  => Abbreviation <=                   =
  ;;========================================================
  (setq-default abbrev-mode t)
  (define-abbrev-table 'global-abbrev-table '(
                                              ;; signature
                                              ("xcx" "gangzhan")
                                              ;; emacs regex
                                              ))
  ;;========================================================
  ;;                   => Auto Insert <=                   =
  ;;========================================================
  (use-package autoinsert
  :ensure nil
  :hook (prog-mode . auto-insert-mode)
  :config
  (defun gangzhan/insert-string(&optional prefix)
    (replace-regexp-in-string
     "^" (or prefix comment-start)
     (concat
      (make-string 80 ?*) "\n"
      "Copyright © " (substring (current-time-string) -4) " " (user-full-name) "\n"
      "File Name: " (file-name-nondirectory buffer-file-name) "\n"
      "Author: " (user-full-name)"\n"
      "Email: " user-mail-address "\n"
      "Created: " (format-time-string "%Y-%m-%d %T (%Z)" (current-time)) "\n"
      "Last Update: \n"
      ;;"         By: \n"
      ;;"Description: \n"
      (make-string 80 ?*))))

  (setq auto-insert-query nil
        auto-insert-alist
        '(((ruby-mode . "Ruby program") nil
           "#!/usr/bin/env ruby\n"
           "# -*- encoding: utf-8 -*-\n"
           (gangzhan/insert-string) "\n")
          ((python-mode . "Python program") nil
           ;; "#!/usr/bin/env python\n"
           "#!/usr/bin/env python3\n"
           "# -*- coding: utf-8 -*-\n"
           (gangzhan/insert-string) "\n")
          ((c-mode . "C program") nil
           "/*"
           (string-trim-left (gangzhan/insert-string " ")) "*/\n"
           "#include<stdio.h>\n"
           "#include<string.h>\n")
          ((sh-mode . "Shell script") nil
           "#!/bin/bash\n"
           (gangzhan/insert-string) "\n")
          ((go-mode . "Go program") nil
           "/*"
           (string-trim-left (gangzhan/insert-string " ")) "*/\n"))))
  (setq time-stamp-active t)
  (setq time-stamp-line-limit 11)
  (setq time-stamp-start "[lL]ast[ -][uU]pdate[ \t]*:?")
  (setq time-stamp-end "\n")
  (setq time-stamp-format " %#A %Y-%02m-%02d %02H:%02M:%02S (%Z)")
  (add-hook 'before-save-hook 'time-stamp)
  ;;========================================================
  ;;                  => Indent Config <=                  =
  ;;========================================================
  (setq-default indent-tabs-mode nil)
  (setq-default default-tab-width 4
                c-basic-offset 4
                ;; JavaScript
                js-basic-offset 2
                js-indent-level 2
                web-mode-code-indent-offset 2
                web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-attr-indent-offset 2
                web-mode-sql-indent-offset 2
                web-mode-style-padding 2
                web-mode-script-padding 2
                web-mode-block-padding 2
                ;; Python
                python-indent-offset 4
                python-spacemacs-indent-guess nil
                )
  (setq c-default-style '(
                          (java-mode . "java")
                          (awk-mode  . "awk")
                          (other     . "linux")
                          )
        )
  (setq scroll-margin 7)
  ;;========================================================
  ;;                  => Indent Line <=                    =
  ;;========================================================
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

  ;; Set the display characteristics
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\▏)

  ;; Change the indent line color

  ;; To tweak the subtlety of these colors
  ;; use the following (all values are percentages)

  (setq highlight-indent-guides-auto-odd-face-perc 15)
  (setq highlight-indent-guides-auto-even-face-perc 15)
  (setq highlight-indent-guides-auto-character-face-perc 50)

  ;; Or, to manually set the colors used for highlighting, use:

  ;;(setq highlight-indent-guides-auto-enabled nil)
  ;;
  ;;(set-face-background 'highlight-indent-guides-odd-face "darkgray")
  ;;(set-face-background 'highlight-indent-guides-even-face "dimgray")
  ;;(set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  ;;========================================================
  ;;                      => Org Mode <=                   =
  ;;========================================================
  (setq org-agenda-files (list "~/org/todo.org"))
  ;; Store org journal files
  (setq org-journal-dir "~/org/journal/")
  ;; Change the journal file name format
  (setq org-journal-format "%Y-%m-%d")
  (setq org-journal-date-prefix "")
  (setq org-journal-date-format "%A, %B %d %Y")
  ;; Adjust the timestamp
  (setq org-journal-time-prefix "* ")
  (setq org-journal-time-format "")
  ;; Modeline support
  (setq spaceline-org-clock-p t)
  ;; LaTeX
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
  (setenv "PATH"
          (concat
           "/usr/local/texlive/2018/bin/x86_64-darwin" ":"
           (getenv  "PATH")
           )
          )
  (let (
        (mypaths
         '(
           "/usr/local/texlive/2018/bin/x86_64-darwin"
           ))
        )
    (setq exec-path (append exec-path mypaths) )
    )

  ;;========================================================
  ;;                  => LaTeX Config <=                   =
  ;;========================================================
    (add-hook 'LaTeX-mode-hook
         (lambda ()
           (setq TeX-auto-untabify t     ; remove all tabs before saving
                    TeX-engine 'xetex       ; use xelatex default
                    TeX-show-compilation t)  ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
  ;;========================================================
  ;;                    => Mode Line <=                    =
  ;;========================================================
  ;; Set the mode display on mode-line
  (spacemacs|diminish highlight-indent-guides-mode " ⓗ" " h")
  (spacemacs|diminish magic-latex-buffer " Ⓜ" " M")
  (spacemacs|diminish reftex-mode " Ⓡ" "R")
  (spacemacs|diminish view-mode " ⓥ" " v")
  (spacemacs|diminish space-doc-mode " ⓢ" " s")
  (spacemacs|diminish helm-mode " Ⓗ" " H")
  (spacemacs|diminish evil-mc-mode " ⓔ" " e")
  (spacemacs|diminish importmagic-mode " Ⓘ" " i")

  ;; Disable purpose segment on mode-line
  (spaceline-toggle-purpose-off)

  ;; Set time display on mode line
  (setq display-time-day-and-date t)
  ;; Remove load average from time string displayed in mode-line
  (setq display-time-default-load-average nil)
  ;; Display time in English
  (setq system-time-locale "C")
  ;; Put this in the end to not to disturb process
  (display-time-mode t)

  ;;========================================================
  ;;                      => Frame <=                      =
  ;;========================================================
  ;; Make frame use natural title bar and make it transparent
  (setq default-frame-alist
        '(
          (ns-transparent-titlebar . t)
          ;; Solve the problem of ghosting title
          ;; but have some problems when using light themes
          ;;(ns-appearance . dark)
          ;; Solved by package `ns-auto-titlebar'
          (alpha . 90)
          )
        )
  (when (eq system-type 'darwin) (ns-auto-titlebar-mode))

  ;; Change frame title
  ;;(setq my-hostname
  ;;      (replace-regexp-in-string
  ;;       "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" ;; like perl chomp()
  ;;       (with-output-to-string
  ;;         (call-process "/bin/hostname" nil standard-output nil))))
  ;;(setq my-username (getenv "USERNAME"))
  ;;(setq frame-title-format '("%b - " my-username "@" my-hostname))
  ;;========================================================
  ;;                => Private Config <=                   =
  ;;========================================================
  (spacemacs//set-monospaced-font   "Source Code Pro" "Hiragino Sans GB" 14 16)
  (setq python-shell-interpreter "/usr/local/bin/python3")
  ;; Get rid of repeat lines in shell
  ;;(setq comint-process-echoes t)  ;; or nil
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (toml-mode racer flycheck-rust cargo rust-mode helm-gtags godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc ggtags flycheck-gometalinter flycheck-golangci-lint counsel-gtags company-go go-mode auctex-latexmk zenburn-theme zen-and-art-theme youdao-dictionary yasnippet-snippets yapfify yaml-mode xterm-color ws-butler writeroom-mode winum white-sand-theme which-key web-mode web-beautify volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package unfill underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toc-org tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit symon sunny-day-theme sublime-themes subatomic256-theme subatomic-theme string-inflection spaceline-all-the-icons spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode shell-pop seti-theme scss-mode sass-mode reverse-theme restart-emacs rebecca-theme rainbow-mode rainbow-identifiers rainbow-delimiters railscasts-theme pyvenv pytest pyim pyenv-mode py-isort purple-haze-theme pug-mode professional-theme prettier-js popwin planet-theme pippel pipenv pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pcre2el password-generator paradox pangu-spacing ox-twbs ox-gfm overseer orgit organic-green-theme org-projectile org-present org-pomodoro org-mime org-journal org-download org-bullets org-brain open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme ns-auto-titlebar noctilux-theme neotree naquadah-theme nameless mwim mustang-theme multi-term move-text monokai-theme monochrome-theme molokai-theme moe-theme mmm-mode minimal-theme material-theme markdown-toc majapahit-theme magit-svn magit-gitflow magic-latex-buffer madhat2r-theme macrostep lush-theme lorem-ipsum livid-mode live-py-mode link-hint light-soap-theme kaolin-themes json-navigator json-mode js2-refactor js-doc jbeans-theme jazz-theme ir-black-theme inkpot-theme indent-guide importmagic impatient-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation highlight-indent-guides heroku-theme hemisu-theme helm-xref helm-themes helm-swoop helm-rtags helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate google-c-style golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md gandalf-theme fuzzy font-lock+ flyspell-correct-helm flycheck-rtags flycheck-pos-tip flx-ido flatui-theme flatland-theme find-by-pinyin-dired fill-column-indicator farmhouse-theme fancy-battery eziam-theme eyebrowse expand-region exotica-theme evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav editorconfig dumb-jump dracula-theme dotenv-mode doom-themes doom-modeline django-theme disaster diminish diff-hl define-word darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme dactyl-mode cython-mode cyberpunk-theme counsel-projectile company-web company-tern company-statistics company-rtags company-lua company-c-headers company-auctex company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-identifiers-mode clues-theme clean-aindent-mode clang-format chinese-conv cherry-blossom-theme centered-cursor-mode busybee-theme bubbleberry-theme browse-at-remote birds-of-paradise-plus-theme badwolf-theme auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes aggressive-indent afternoon-theme ace-window ace-pinyin ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
