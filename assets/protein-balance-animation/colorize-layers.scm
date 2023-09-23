(define (batch-colorize-layers pattern)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* ((filename (car filelist))
                  (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
                  (layers '("Axes" "Breakdown copy" "Synthesis copy" "Protein Balance Bar" "Meal Arrow" "Meal Arrow copy" "Meal Arrow 1" "Meal Arrow 2" "Meal Arrow 3")))
             (while (not (null? layers))
                    (let* ((layer-name (car layers))
                           (layer (car (gimp-image-get-layer-by-name image layer-name))))
                      (if (not (= layer -1))
                          (begin
                            (gimp-colorize layer 0 0 100)))
                      (set! layers (cdr layers))))
             (gimp-file-save RUN-NONINTERACTIVE image (car (gimp-image-get-active-layer image)) filename filename)
             (gimp-image-delete image))
           (set! filelist (cdr filelist)))))