;;; /Volumes/DATA/work/emacs/doom.d/+org.el -*- lexical-binding: t; -*-
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(after! org
  (setq org-log-into-drawer t)
  (setq org-archive-location "archive.org::* From %s")
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (setq org-todo-keywords
   '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)")
     (sequence "[ ](T)" "[-](P)" "[?](M)" "|" "[X](D!)")
     (sequence "NEXT(n)" "WAIT(w@/!)" "HOLD(h@/!)" "|" "ABRT(c!)"))))
