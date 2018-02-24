(defun ubiquity-create-buffer ()
  (interactive)
  (let ((ubiquity-buffer (get-buffer-create "*Ubiquity*")))
    (progn
      (with-current-buffer ubiquity-buffer
	(ubiquity-mode))
    (switch-to-buffer ubiquity-buffer))))



(defun ubiquity-buffer-to-clipboard ()
  "Send the contents of the *Ubiquity* buffer to the clipboard."
  (let ((ubiquity-contents (buffer-substring (point-min) (point-max)))
	(history-buffer (get-buffer-create "*Ubiquity-History*")))
    (progn
      (with-current-buffer "*Ubiquity*"
	(kill-new ubiquity-contents))
      (with-current-buffer "*Ubiquity-History*"
	(insert ubiquity-contents)
	(newline)))))


(defun ubiquity-clipboard-copy-and-bury ()
  "Copy contents of the *Ubiquity* buffer to the clipboard and bury the buffer."
  (interactive)
  (progn
    (ubiquity-buffer-to-clipboard)
    (with-current-buffer "*Ubiquity*"
      (quit-window t))))


(defvar ubiquity-mode-hook nil)

(define-key ubiquity-mode-map
  (kbd "C-c C-c") 'ubiquity-clipboard-copy-and-bury)


(define-derived-mode ubiquity-mode
  text-mode "Ubiquity"
  "Use Emacs anywhere..")
