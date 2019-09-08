;;; ~/.doom.d/lisp/init-func.el -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Basic configurations.
;;

;;; Code:
;;========================================================
;;                      => Theme <=                      =
;;========================================================
(setq dalu-current-theme-index 0)
(setq dalu-cycle-themes (mapcar 'symbol-name dalu-theme-list))

(defhydra dalu/cycle-themes ()
  ("n" dalu/next-theme "next theme")
  ("p" dalu/previous-theme "prev theme"))

(defun dalu/next-theme()
  (interactive)
  (dalu/cycle-theme (+ dalu-current-theme-index 1)))

(defun dalu/previous-theme()
  (interactive)
  (dalu/cycle-theme (- dalu-current-theme-index 1)))

(defun dalu/cycle-theme (num)
  "Cycle through a list of themes among dalu-theme-list."
  (interactive)
  (setq dalu-current-theme-index
        (+ num
           (cl-position
            (car (mapcar 'symbol-name dalu-theme-list)) dalu-cycle-themes :test 'equal)))
  (when (>= dalu-current-theme-index (length dalu-cycle-themes))
    (setq dalu-current-theme-index 0))
  (setq dalu-current-theme (nth dalu-current-theme-index dalu-cycle-themes))
  (mapc 'disable-theme dalu-theme-list)
  (let ((progress-reporter
         (make-progress-reporter
          (format "Loading theme %s..." dalu-current-theme))))
    (load-theme (intern dalu-current-theme) t)
    (progress-reporter-done progress-reporter)))

;;===========================================================
;;=                    => Personal Func <=                  =
;;===========================================================
(defun dalu/open-my-init-file()
  (interactive)
  (find-file "~/.doom.d/init.el"))

(defun dalu/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;; Indent function
(defun dalu/indent-buffer()
  (interactive)
  (indent-region (point-min)(point-max)))
(defun dalu/indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (dalu/indent-buffer)
        (message "Indent buffer.")))))

;; 解决不同系统下换行符的问题

;; 隐藏的方法
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

;; 删除的方法
;;(defun remove-dos-eol ()
;;  "Replace DOS eolns CR LF with Unix eolns CR"
;;  (interactive)
;;  (goto-char (point-min))
;;  (while (search-forward "\r" nil t) (replace-match "")))

;;========================================================
;;; init-func.el ends here
