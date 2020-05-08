#!/bin/bash

  mkdir -p prod

  gawk '

    BEGIN {
      OFS = "\t";
      id  = 1000;
    }

    $1 {
      of = "prod/" id ".html";
      print "test -f " of " || ./03__get-prod.sh " of " " $1 > "03__get.sh";
      print id, $1 > "url-02.txt";
      id++;
    }


  ' prodoct-links.txt


