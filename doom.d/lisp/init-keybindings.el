;;; ~/.doom.d/lisp/init-keybindings.el -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Basic configurations.
;;

;;; Code:
;;===========================================================
;;=                   => Shortcut <=                        =
;;===========================================================
;; My personal function
(global-set-key (kbd "<f11>") 'dalu/fullscreen)
(global-set-key (kbd "<f12>") 'dalu/open-my-init-file)
(global-set-key (kbd "C-c t") 'dalu/cycle-themes/body)
;; Built in function
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
;;===========================================================
;;=                    => org mode <=                       =
;;===========================================================
(global-set-key (kbd "C-c r") 'org-capture)

;;===========================================================
;;=                  => Indent Config <=                    =
;;===========================================================
(global-set-key (kbd "C-M-\\") 'dalu/indent-region-or-buffer)

;;===========================================================
;;; init-keybindings.el ends here
