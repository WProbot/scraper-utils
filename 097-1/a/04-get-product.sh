#!/bin/bash

#
#
#

  gawk '

    END {
      print " date >> 00-keszvan.txt";
    }

    /<\/div>/ {
      flag = 0;
    }

    flag {
       if($0 ~ /<a href/) {
         gsub("^.*href=.", "");
         gsub("\".*$", "");
         url = "https://www. .... .com" $0;
       }
    }

    /<div class="product-list-item">/ {
      flag++;
      url = "";
    }

    /<span>€/ {
      getline;
      getline;
      id = $0+0;
      oke = "   ";
      cnt["osszes"]++;
      if(testfile(id)) {
        oke = "## ";
        cnt["megvan"]++;
      } else {
        cnt["nincs"]++;
      }
      bf = sprintf("04-%d-get-all-prod.sh", ++getfcnt % 3);
      print oke "./get-prod.sh", url, id > bf;
      printf("%10s\t%s\n", id, url) > "out-99-all-product.txt";
    }


    function testfile(id,  fn, r) {
      r = 0;
      fn = "/DEV/097/prod/" id ".html";
      if(0 < (getline < fn)) {
        r++;
        close(fn);
      }
      return r;
    }


    END  {
      for(q in cnt) {
        print q, cnt[q] > "out-99-prod-cnt.txt";
      }
    }

  ' out-03-cat-*.html

#

