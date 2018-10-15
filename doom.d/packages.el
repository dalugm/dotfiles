;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! highlight-indent-guides)
(package! cache-path-from-shell :recipe
          (:fetcher github
                    :repo "manateelazycat/cache-path-from-shell"))
