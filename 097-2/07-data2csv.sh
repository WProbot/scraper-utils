#!/bin/bash

#
#  data2csv.sh  SABTCU
#


#-----------------------------------------------

  gawk '

#-----------------------------------------------

    BEGIN {

      FS = OFS = "\t";


      dn[dncnt++] = "cat1"
      dn[dncnt++] = "cat2"
      dn[dncnt++] = "cat3"


      dn[dncnt++] = "name"
      dn[dncnt++] = "title"

      dn[dncnt++] = "rrp"
      dn[dncnt++] = "rrp_h"
      dn[dncnt++] = "price"
      dn[dncnt++] = "price_h"

      dn[dncnt++] = "oid"
      dn[dncnt++] = "stock"
      dn[dncnt++] = "limit"

      dn[dncnt++] = "coll"
      dn[dncnt++] = "matrl"
      dn[dncnt++] = "dim"

      dn[dncnt++] = "desc"
      dn[dncnt++] = "url"


      dn[dncnt++] = "img1"
      dn[dncnt++] = "img2"
      dn[dncnt++] = "img3"
      dn[dncnt++] = "img4"
      dn[dncnt++] = "img5"
      dn[dncnt++] = "img6"


      for(q=0; q<dncnt; q++) {
        printf "%s\t", dn[q] > "xx-header.txt";
      }
      printf "\n" > "xx-header.txt";

  }

#-----------------------------------------------

  /^--+/ {

    for(q=0; q<dncnt; q++) {
      printf "%s\t", data[dn[q]];
    }
    printf "\n";

    delete data;

    next;

  }

#-----------------------------------------------

  $1 {
    data[$2] = $3;
  }


#-----------------------------------------------

  ' xx-out.txt | sort -u > xx-tab.txt

#-----------------------------------------------

  mkdir -p out

#-----------------------------------------------

  gawk '

    BEGIN {

      FS = OFS = "\t";

      getline < "xx-header.txt";

      of[0] = "out/homeware-tab.txt";
      of[1] = "out/kids-tab.txt";

      print $0 > of[0];
      print $0 > of[1];

    }

#-----------------------------------------------

    $1 {
      print $0 > of[!($1 ~ /^home/)];
    }

#-----------------------------------------------

  '  xx-tab.txt

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


  ' out/homeware-tab.txt > out/homeware.csv

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

  ' out/kids-tab.txt > out/kids.csv

#-----------------------------------------------

#-#
