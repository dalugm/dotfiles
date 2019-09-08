;;; ~/.doom.d/lisp/init-ui.el -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Basic configurations.
;;

;;; Code:
;;========================================================
;;                       => Font <=                      =
;;========================================================
(setq doom-font (font-spec :family "FuraMono Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "FuraMono Nerd Font")
      doom-unicode-font (font-spec :family "DejaVuSansMono Nerd Font")
      doom-big-font (font-spec :family "FuraMono Nerd Font Mono" :size 19))

;;===========================================================
;;=                => Smooth Scrolling <=                   =
;;===========================================================
;; scroll better for watching
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 7)
;;===========================================================
;;=                 => Minor Mode Config <=                 =
;;===========================================================
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))
;;==========================================================
;;                      => Frame <=                        =
;;==========================================================
;; Make frame use natural title bar and make it transparent
(setq default-frame-alist
      '(
        (fullscreen . maximized)
        (ns-transparent-titlebar . t)
        ;; Solve the problem of ghosting title
        ;; but have some problems when using light themes
        ;;(ns-appearance . dark)
        ;; Solved by package `ns-auto-titlebar'
        (alpha . 90)
        )
      )
(when (eq system-type 'darwin) (ns-auto-titlebar-mode))

;;   Change frame title
(setq my-hostname
      (replace-regexp-in-string
       "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" ;; like perl chomp()
       (with-output-to-string
         (call-process "/bin/hostname" nil standard-output nil))))
(setq my-username (getenv "USERNAME"))
(setq frame-title-format '("%b - " my-username "@" my-hostname))

;;========================================================
;;; init-ui.el ends here
