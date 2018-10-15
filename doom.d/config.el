;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
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
;;                  => Indent Config <=                  =
;;========================================================
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4
      c-basic-offset 4
      ;; Uncomment the next line is very unsafe
      ;;python-indent-guess-indent-offset nil
      )

(setq c-default-style '(
                        (java-mode . "java")
                        (awk-mode  . "awk")
                        (other     . "linux")
                        ))
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
;; Store org journal files
(setq org-journal-dir "~/org/journal/")
;; Change the journal file name format
(setq org-journal-format "%Y-%m-%d")
(setq org-journal-date-prefix "")
(setq org-journal-date-format "%A, %B %d %Y")
;; Adjust the timestamp
(setq org-journal-time-prefix "* ")
(setq org-journal-time-format "")
;;========================================================
;;                    => Mode Line <=                    =
;;========================================================
(setq +doom-modeline-height 40)
(setq +doom-modeline-bar-width 5)
;;========================================================
;;                      => Frame <=                      =
;;========================================================
;; Make frame use natural title bar and make it transparent
(setq default-frame-alist
      '(
        (fullscreen . maximized)
        (ns-transparent-titlebar . t)
        ;; Solve the problem of ghosting title
        ;; but have some problems when using light themes
        (ns-appearance . dark)
        (alpha . 90)
        )
      )

;; Change frame title
(setq my-hostname
      (replace-regexp-in-string
       "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" ;; like perl chomp()
       (with-output-to-string
         (call-process "/bin/hostname" nil standard-output nil))))
(setq my-username (getenv "USERNAME"))
(setq frame-title-format '("%b - " my-username "@" my-hostname))

;; Frame bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Emacs font
(set-default-font "source code pro")
(set-face-attribute 'default nil :height 140)
;; Dashboard
;;========================================================
;;                => Private Config <=                   =
;;========================================================
(require 'cache-path-from-shell)
