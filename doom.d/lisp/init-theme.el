;;; ~/.doom.d/lisp/init-theme.el -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Basic configurations.
;;

;;; Code:
;;========================================================
;;                      => Theme <=                      =
;;========================================================
;; Cycle through this set of themes
(defvar dalu-theme-list '(
                          doom-one
                          doom-solarized-dark
                          doom-tomorrow-night
                          doom-molokai
                          doom-nord
                          doom-nord-light
                          doom-tomorrow-day
                          doom-one-light
                          doom-solarized-light
                          )
  )
(defvar dalu-current-theme nil
  "Internal variable storing currently loaded theme.")
(defvar dalu-fallback-theme 'doom-one
  "Fallback theme if user theme cannot be applied.")

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;;========================================================
;;; init-theme.el ends here.
