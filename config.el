;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; machine specific extra config
;; org-idx could be set here
(setq host-custom-init (concat "~/" system-name ".el"))
(if (file-exists-p host-custom-init)
    (load-file host-custom-init))

;;-----------------------------------------
;;Title format : buffer name @ hostname
;;------------------------------------------
(setq frame-title-format (concat "%b@emacs." system-name))

; https://emacs.stackexchange.com/questions/36745/enable-ivy-fuzzy-matching-everywhere-except-in-swiper
(setq ivy-re-builders-alist
      '(
        (counsel-M-x . ivy--regex-fuzzy)
        (t . ivy--regex-plus))
      )

(when (display-graphic-p)
  ;;run M-x all-the-icons-install-fonts to use icons theme
  ;(setq neo-theme 'icons)
  (if IS-WINDOWS
      (setq my-font "Consolas-10")
    (if IS-MAC
        (setq my-font "SF Mono-12")
      (setq my-font "Fira Code Retina-10")))
  (set-default-font my-font)
  (set-face-attribute 'default t
                      :font my-font)
  (set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" . "unicode-bmp")))

;; {{ tramp setup
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))
(setq tramp-chunksize 8192)

;; @see https://github.com/syl20bnr/spacemacs/issues/1921
;; If you tramp is hanging, you can uncomment below line.
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
;; }}


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


(when IS-MAC
  (global-unset-key [home])
  (global-set-key [home] 'move-beginning-of-line)
  (global-unset-key [end])
  (global-set-key [end] 'move-end-of-line)
  )
