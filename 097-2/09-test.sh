#!/bin/bash

  grep "product available" sout/*.html | sort -u | gawk '

    /sout/ {
      $0 = $1;
      gsub("^.*/",   "");
      gsub("[.].*$", "");
      print $0 > "oke.txt";
    }

   '

  wc -l oke.txt


#-#
