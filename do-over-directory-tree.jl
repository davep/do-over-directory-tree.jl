(define do-over-directory-tree
  (lambda (root filter action)
    "Perform an action over files found in a directory tree

ROOT is the root of the tree to traverse.

FILTER is a function that will be applied against the name of each file
found. Only if this function returns a non-nil value will ACTION be
performed against the file.

ACTION is a function that is called with the name of each file that passes
the FILTER test."
    (mapc (lambda (file)
            (let ((current-file (concat (file-name-as-directory root) file)))
              (if (file-directory-p current-file)
                  (unless (or (string= file ".") (string= file ".."))
                    (do-over-directory-tree current-file filter action))
                (when (filter current-file)
                  (action current-file)))))
          (directory-files root))))
