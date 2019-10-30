;;; private/my-python/config.el -*- lexical-binding: t; -*-
(add-to-list 'auto-mode-alist '("\\SConscript$" . python-mode))
(add-to-list 'auto-mode-alist '("\\SConstruct$" . python-mode))
(setq python3 (executable-find "python3"))
(when (not (equal nil python3))
  (setq elpy-rpc-python-command python3)
  (setq elpy-interactive-python-command python3))
(setq python-shell-interpreter "ipython3" python-shell-interpreter-args "-i --simple-prompt")


(after! python
  (add-hook! 'python-mode-local-vars-hook
             :append
             (defun adjust-python-minor-modes ()
               "use anaconda for local file and elpy for remote file"
               (if (string-match-p "\/[^\/]*ssh:" buffer-file-name)
                   (progn (anaconda-mode -1)
                          (anaconda-eldoc-mode -1)
                          (elpy-enable)
                          (message "remote python file"))
                 (message "local python file")))))
