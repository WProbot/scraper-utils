#!/bin/bash


  BASE=https://www......com/ ..... /


 ./get.sh $BASE          out-01-index.html


  gawk '

    BEGIN {
      OFS = "\t";
    }

    /<a href=".en.products.zomer-ete-summer-2020./ {
      gsub("^.*href=.", "");
      gsub("\".*$", "");
      url = "https://www.........com" $0;
      cn = url;
      gsub("/$", "", cn);
      gsub("^.*/", "", cn);
      getline;
      if($0 ~ /<p class="subtitle tiny">/) {
        gsub("<[^>]*>", "");
        gsub("[\t ]+", " ");
        gsub("(^ | $)", "");
        print cn, url, $0;
        hf = "out-03-cat-" cn "-01.html";
        print cn, "01", hf, url > "out-02-pages.txt";
      }
    }


  '  out-01-index.html  > out-02-catalog.txt


  gawk '

    BEGIN {
      FS = "\t";
    }

    !_[$1]++ {
      print "./get.sh", $2, hf;
    }

  ' out-02-catalog.txt > 02-get-cat-main.sh

  . 02-get-cat-main.sh



