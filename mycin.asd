(asdf:defsystem :mycin
                :name "Mycin"
                :licence "MIT"
                :description "A Famous Expert System for Infections Disease"
                :serial t
                :components ((:file "mycinutils")
                             (:file "mycin")
                             (:file "mycin-r")))