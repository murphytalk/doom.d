;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; machine specific extra config
;; org-idx could be set here
(setq host-custom-init (concat "~/" system-name ".el"))
(if (file-exists-p host-custom-init)
    (load-file host-custom-init))


;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt))
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (>= emacs-major-version 24))
(setq *emacs25* (>= emacs-major-version 25))
(setq *emacs26* (>= emacs-major-version 26))

; https://emacs.stackexchange.com/questions/36745/enable-ivy-fuzzy-matching-everywhere-except-in-swiper
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

(when (display-graphic-p)
  ;;run M-x all-the-icons-install-fonts to use icons theme
  (setq neo-theme 'icons)
  (if *win64*
      (setq my-font "Consolas-10")
    (if *is-a-mac*
        (setq my-font "SF Mono-12")
      (setq my-font "Fira Code Retina-10")))
  (set-default-font my-font)
  (set-face-attribute 'default t
                      :font my-font)
  (set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" . "unicode-bmp")))

;;===========================================================================
;; Keys mapping
;;===========================================================================

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; https://github.com/emacs-helm/helm-ls-git
(global-set-key (kbd "M-p") 'helm-ls-git-ls)

(global-set-key [(control -)] 'set-mark-command)
(when (not (equal nil org-idx))
  (global-set-key [f2]
                  '(lambda()
                     (interactive)
                     (find-file org-idx))))
(global-set-key [f4] 'ibuffer)
(global-set-key [f5] 'neotree-toggle)
(global-set-key [(meta g)] 'goto-line)


(when *is-a-mac*
  (global-unset-key [home])
  (global-set-key [home] 'move-beginning-of-line)
  (global-unset-key [end])
  (global-set-key [end] 'move-end-of-line)
  )
