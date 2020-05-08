#!/bin/bash

  gawk '

    /<loc>.*[/](homeware|kids)[/]/ {
      gsub("<[^>]*>", "");
      gsub("[\t\r ]+", "");
      print $0;
    }


  ' *.xml | sort -u > prodoct-links.txt


