;;; ieeetran.el --- Clase IEEEtran en org-mode emacs.  -*- lexical-binding: t; -*-
;;; Commentary:
;; Author: Eduardo V. <hao@arch>
;; Keywords: extensions, tools
;;; Code:

(defvar ieeetran-class
  '("IEEEtran" "\\documentclass[11pt]{IEEEtran}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes ieeetran-class t)

(defun org-remove-headlines (backend)
  "Remove headlines with :no_title: tag."
  (org-map-entries (lambda () (let ((beg (point)))
                           (outline-next-visible-heading 1)
                           (backward-char)
                           (delete-region beg (point))))
                   "no_export" tree)
  (org-map-entries (lambda () (delete-region (point-at-bol) (point-at-eol)))
                   "no_title"))

(add-hook 'org-export-before-processing-hook #'org-remove-headlines)
