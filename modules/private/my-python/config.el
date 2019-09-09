;;; private/my-python/config.el -*- lexical-binding: t; -*-
(add-hook 'python-mode-hook #'adjust-python-minor-modes)

(add-to-list 'auto-mode-alist '("\\SConscript$" . python-mode))
(add-to-list 'auto-mode-alist '("\\SConstruct$" . python-mode))
(setq python3 (executable-find "python3"))
(when (not (equal nil python3))
  (setq elpy-rpc-python-command python3)
  (setq elpy-interactive-python-command python3)
  )
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i --simple-prompt")
