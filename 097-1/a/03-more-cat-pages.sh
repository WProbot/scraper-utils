#!/bin/bash


  gawk '

    BEGIN {
      OFS = "\t";
    }

    /<li><a href="en.products.zomer-ete-summer-2020.catalogue-zomer-ete-summer-2020.[-a-z]+.[?]page=[0-9]+">/ {
      gsub("^.*href=.", "");
      gsub("\".*$", "");
      cat = page = $0;
      url = "https://www.........com/" $0;
      gsub("/[^/]*$", "", cat);
      gsub("^.*/", "", cat);
      gsub("^.*=", "", page);
      npage = sprintf("%02d", page+0);
      hf = "out-03-cat-" cat "-" npage ".html";
      print cat, npage, hf, url > "out-03-pages.txt";;
    }

  ' out-03-cat*.html



  gawk '

    BEGIN {
      OFS = "\t";
    }

    !_[$4]++ {
      print "./get.sh", $4, $3;
    }


  ' out-*-pages.txt > 03-get-cat-more.sh

  . 03-get-cat-more.sh 


  sort -u out-*-pages.txt > out-99-catalog-pages.txt
