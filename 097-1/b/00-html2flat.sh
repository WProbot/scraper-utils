#!/bin/bash


  gawk '

    $2 {
      id  = $1;
      url = $2;
      pf  = "/DEV/097/prod/" id ".html";
      print "./html2flat.sh", pf, url, ">> output.txt";
    }

  '  out-*-product.txt > make-output.sh

  test -f output.txt && rm output.txt

  screen time bash make-output.sh