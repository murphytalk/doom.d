(setq ivy-re-builders-alist '((counsel-M-x . ivy--regex-fuzzy)
                              (t . ivy--regex-plus)))

(setq dumb-jump-selector 'ivy)

(after! deft
  (setq deft-recursive t)
  ;;don't auto save my notes
  (setq deft-auto-save-interval 0))

(after! ispell
  (when IS-MAC
    ;; flyspell uses middle mouse button to show candidates by default
    ;; replace it with right mouse on mac
    (eval-after-load "flyspell" '(progn (define-key flyspell-mouse-map [down-mouse-3]
                                          #'flyspell-correct-word)
                                        (define-key flyspell-mouse-map [mouse-3] #'undefined)))))

(setq frame-title-format (concat "%b@emacs." system-name))

(when (display-graphic-p)
  ;;run M-x all-the-icons-install-fonts to use icons theme
  ;;(setq neo-theme 'icons)
  (if IS-WINDOWS
      (setq my-font "Consolas-10")
    (if IS-MAC
        (setq my-font "SF Mono-12")
      (setq my-font "Mono-10")))
  (set-default-font my-font)
  (set-face-attribute 'default t
                      :font my-font)
  (if IS-WINDOWS (set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" .
                                                                "unicode-bmp"))))

(global-set-key (kbd "C-x g") 'magit-status)

;; https://github.com/emacs-helm/helm-ls-git
(global-set-key (kbd "M-p") 'helm-ls-git-ls)

(global-set-key [(control -)] 'set-mark-command)

(global-set-key [f2] 'deft)
(global-set-key [f4] 'ibuffer)
(global-set-key [f5] 'neotree-toggle)
(global-set-key (kbd "C-S-g") 'goto-line)

(when IS-MAC (global-unset-key [home])
      (global-set-key [home] 'move-beginning-of-line)
      (global-unset-key [end])
      (global-set-key [end] 'move-end-of-line))

(require 'flx-ido) ; fuzzy match
(ido-mode 'file)  ; use 'buffer rather than t to use only buffer switching
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)
;; @see https://github.com/lewang/flx
(setq flx-ido-threshold 10000)
;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

;; disable ido for certain commands,
;; @see http://stackoverflow.com/questions/6771664/disable-ido-mode-for-specific-commands
(defadvice ido-read-buffer (around ido-read-buffer-possibly-ignore activate)
  "Check to see if use wanted to avoid using ido"
  (if (eq (get this-command 'ido) 'ignore)
      (let ((read-buffer-function nil))
        (run-hook-with-args 'ido-before-fallback-functions 'read-buffer)
        (setq ad-return-value (apply 'read-buffer (ad-get-args 0))))
    ad-do-it))
(put 'shell 'ido 'ignore)
(put 'ffap-alternate-file 'ido 'ignore)
(put 'tmm-menubar 'ido 'ignore)
(put 'dired-do-copy 'ido 'ignore)
(put 'dired-do-rename 'ido 'ignore)
(put 'vc-copy-file-and-rename-buffer 'ido 'ignore)
(put 'dired-create-directory 'ido 'ignore)
(put 'copy-file-and-rename-buffer 'ido 'ignore)
(put 'rename-file-and-buffer 'ido 'ignore)
(put 'w3m-goto-url 'ido 'ignore)
(put 'ido-find-file 'ido 'ignore)
(put 'ido-edit-input 'ido 'ignore)
(put 'read-file-name 'ido 'ignore)
(put 'dired-create-directory 'ido 'ignore)
(put 'minibuffer-completion-help 'ido 'ignore)
(put 'minibuffer-complete 'ido 'ignore)
(put 'c-set-offset 'ido 'ignore)
(put 'rgrep 'ido 'ignore)
(put 'dired-create-directory 'ido 'ignore)

(add-to-list 'backup-directory-alist (cons tramp-file-name-regexp nil))
(setq tramp-chunksize 8192)
;; @see https://github.com/syl20bnr/spacemacs/issues/1921
;; If you tramp is hanging, you can uncomment below line.
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

(setq host-custom-init (concat "~/" system-name ".el"))
(if (file-exists-p host-custom-init)
    (load-file host-custom-init))
