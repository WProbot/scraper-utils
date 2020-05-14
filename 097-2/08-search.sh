#!/bin/bash

  mkdir -p sout

  cat ../04/out/*-tab.txt | gawk '

    BEGIN {
      FS = OFS = "\t";
    }

    $1 {
      of = "sout/" $10 ".html";
      print "test -f " of " ||  wget -a wget.log \"https:// ... searchterm=" $10 "&searchterm_submit=go\" -O", of;
    }


  ' > _get.sh

#-#
