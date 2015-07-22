(define-minor-mode ltex-mode
  "Crear documentos LaTeX fácilmente."
  :lighter " ltex"
  :keymap
  `((,(kbd "C-c C-g e") . glossary-entry)
    (,(kbd "C-c C-g f") . glossary-entry-full)
    (,(kbd "C-c C-g a") . glossary-entry-acronym)
    (,(kbd "C-c C-g d") . glossary-entry-dual)
    (,(kbd "C-c C-g t") . glossary-term)
    (,(kbd "C-c C-g c") . bib-cite)
    (,(kbd "C-x e") . glossary-entry-next-position)
    (,(kbd "(") . skeleton-pair-insert-maybe)
    (,(kbd "{") . skeleton-pair-insert-maybe)
    (,(kbd "\"") . skeleton-pair-insert-maybe)
    (,(kbd "[") . skeleton-pair-insert-maybe))
  (setq skeleton-pair (boundp 'ltex-mode)))

(define-skeleton glossary-entry
  "Inserta un item al glosario"
  ""
  >"\\newgl"
  "{" @ _ "}"
  "{" @ _ "}"
  "{" @ _ "}")

(define-skeleton glossary-entry-advanced
  "Inserta un item al glosario"
  ""
  >"\\newglossaryentry{" @ - "}{" \n
  >"name={" @ _ "}," \n
  >"description={" @ _ "}," \n
  >"symbol={" @ _ "}," \n
  >"plural={" @ _ "}" \n
  >"}" \n)

(define-skeleton bib-cite
  "Agrega una referencia bibliográfica."
  "Alias de la cita: "
  "\\cite{" str "}" @ -)

(define-skeleton glossary-term
  "Agrega una referencia del glosario."
  "Alias de la referencia: "
  "\\gls{" str "}" @ - )

(defvar *glossary-entry-markers* nil
  "Markers for locations saved in glossary-entry-positions")

(add-hook 'skeleton-end-hook 'glossary-entry-make-markers)

(defun glossary-entry-make-markers ()
  (while *glossary-entry-markers*
    (set-marker (pop *glossary-entry-markers*) nil))
  (setq *glossary-entry-markers*
        (mapcar 'copy-marker (reverse skeleton-positions))))

(defun glossary-entry-next-position (&optional reverse)
  "Jump to next position in skeleton.
         REVERSE - Jump to previous position in skeleton"
  (interactive "P")
  (let* ((positions (mapcar 'marker-position *glossary-entry-markers*))
         (positions (if reverse (reverse positions) positions))
         (comp (if reverse '> '<))
         pos)
    (when positions
      (if (catch 'break
            (while (setq pos (pop positions))
              (when (funcall comp (point) pos)
                (throw 'break t))))
          (goto-char pos)
        (goto-char (marker-position
                    (car *glossary-entry-markers*)))))))

(add-hook 'latex-mode-hook 'ltex-mode)
