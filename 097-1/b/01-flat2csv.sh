#!/bin/bash


  gawk '

    BEGIN {
      FS = OFS = "\t";
    }

    /^---/ {
      out = "";
      next;
    }

    /^cat/ {
      cf = $2;
      gsub(" ", "_", cf);
      oft   = "product-" cf "-tab.txt";
      ofcsv = "product-" cf "-csv.txt";
    }

    /^end/ {
      headerflag=1;
      if(!_hf[oft]++) {
        print header > oft;
        headercv = header;
        gsub("\"", "", headercv);
        gsub("\t", "\",\"", headercv);
        print "\"" headercv "\"" > ofcsv;
      }
      print out > oft;
      gsub("\"", "", out);
      gsub("\t", "\",\"", out);
      print "\"" out "\"" > ofcsv;
      next;
    }

    !headerflag {
      header = header $1 "\t";
    }

    $1 {
      out = out $2 "\t";
    }


  '  output-flat.txt

