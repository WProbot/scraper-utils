#!/bin/bash

#-----------------------------------------------

  mkdir -p tab

#-----------------------------------------------

  gawk '


    BEGIN {

      FS = OFS = "\t";

      while(0 < (getline < "oke.txt")) {
        oke[$1]++;
      }

    }

    $1 {
      id = $10;
      of = FILENAME;
      gsub("^.*/", "", of);
      of = "tab/" of;
      $25 = oke[$10]+0;
      print $0 > of;
    }


  ' ../04/out/*-tab.txt


#-----------------------------------------------

  gawk '

    BEGIN {
      FS = "\t";
    }

    $1 {
      gsub("\"", "");
      gsub("\t", "\",\"");
      print "\"" $0 "\""
    }

  ' tab/kids-tab.txt > tab/kids.csv

#-----------------------------------------------


  gawk '

    BEGIN {
      FS = "\t";
    }

    $1 {
      gsub("\"", "");
      gsub("\t", "\",\"");
      print "\"" $0 "\""
    }

  ' tab/homeware-tab.txt > tab/homeware.csv

#-----------------------------------------------

  cp oke.txt tab

#-----------------------------------------------

#-#
