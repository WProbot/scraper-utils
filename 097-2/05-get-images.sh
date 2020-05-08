#!/bin/bash

  mkdir -p img

  cat xx-inage.txt | gawk '

    BEGIN {
      FS = "\t";
    }

    $2 {
      print "wget -a wget.log", "\"https://www.........net" $1 "\"", "-O", "img/" $2
    }


  ' > 06-wget.sh

#