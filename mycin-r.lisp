;;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; Code from Paradigms of AI Programming
;;;; Copyright (c) 1991 Peter Norvig

;;;; File mycin-r.lisp: Sample parameter list and rulebase for mycin.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "mycin")
  )

;;; Parameters for patient:
(defparm name PATIENT t "Patient's name: " t read-line)
(defparm sex PATIENT (member male female) "Sex:" t)
(defparm age PATIENT number "Age:" t)
(defparm burn PATIENT (member no mild serious)
  "Is ~a a burn patient?  If so, mild or serious?" t)
(defparm compromised-host PATIENT yes/no
  "Is ~a a compromised host?")

;;; Parameters for culture:
(defparm site CULTURE (member blood)
  "From what site was the specimen for ~a taken?" t)
(defparm days-old CULTURE number
  "How many days ago was this culture (~a) obtained?" t)

;;; Parameters for organism:
(defparm identity ORGANISM
  (member pseudomonas klebsiella enterobacteriaceae
          staphylococcus bacteroides streptococcus)
  "Enter the identity (genus) of ~a:" t)
(defparm gram ORGANISM (member acid-fast pos neg)
  "The gram stain of ~a:" t)
(defparm morphology ORGANISM (member rod coccus)
  "Is ~a a rod or coccus (etc.):")
(defparm aerobicity ORGANISM (member aerobic anaerobic))
(defparm growth-conformation ORGANISM 
  (member chains pairs clumps))

(clear-rules)

(defrule 52
  if (site CULTURE is blood)
     (gram ORGANISM is neg)
     (morphology ORGANISM is rod)
     (burn PATIENT is serious)
  then .4
     (identity ORGANISM is pseudomonas))

(defrule 71
  if (gram ORGANISM is pos)
     (morphology ORGANISM is coccus)
     (growth-conformation ORGANISM is clumps)
  then .7
     (identity ORGANISM is staphylococcus))

(defrule 73
  if (site CULTURE is blood)
     (gram ORGANISM is neg)
     (morphology ORGANISM is rod)
     (aerobicity ORGANISM is anaerobic)
  then .9
     (identity ORGANISM is bacteroides))

(defrule 75
  if (gram ORGANISM is neg)
     (morphology ORGANISM is rod)
     (compromised-host PATIENT is yes)
  then .6
     (identity ORGANISM is pseudomonas))

(defrule 107
  if (gram ORGANISM is neg)
     (morphology ORGANISM is rod)
     (aerobicity ORGANISM is aerobic)
  then .8
     (identity ORGANISM is enterobacteriaceae))

(defrule 165
  if (gram ORGANISM is pos)
     (morphology ORGANISM is coccus)
     (growth-conformation ORGANISM is chains)
  then .7
     (identity ORGANISM is streptococcus))

