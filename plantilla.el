;;; ieeetran.el --- Clase IEEEtran en org-mode emacs.  -*- lexical-binding: t; -*-

;; Author: Eduardo V. <hao@arch>
;; Keywords: extensions, tools

(setq ieeetran-class
      '("IEEEtran" "\\documentclass[11pt]{IEEEtran}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes ieeetran-class t)
