#!/bin/bash

  gawk -v URL=$2 '

    BEGIN {
      OFS = "\t";
      pinstock=0;
    }

    # <h3 class="product-title mb-2"><b>Decoration Garden Flat Rabbit Iron Rust</b> <span>(1028)</span></h3>
    /<h3 class="product-title/ {
      gsub("<[^<]*>", " ");
      gsub("[\t ]+", " ");
      pid = ptitle = $0;
      gsub("^.*[(]", "", pid);
      gsub("[)].*$", "", pid);
      gsub("[(][^(]*$", "", ptitle);
      gsub("(^ | $)", "", ptitle);
      next;
    }

    #  Single unit price: <span class="product-price product-price-lg">€&nbsp;4.44</span>
    /Single unit price:/ {
      gsub("^.*<span[^>]*>", "");
      gsub("</span>.*$", "");
      gsub("&nbsp;", " ");
      sub("^..", "");
      psprice = $0;
      next;
    }


    # Retail price: <span class="product-price">€&nbsp;10.90</span>
    /Retail price:/ {
      gsub("^.*<span[^>]*>", "");
      gsub("</span>.*$", "");
      gsub("&nbsp;", " ");
      sub("^..", "");
      prprice = $0;
      next;
    }


    /<td>Material:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      gsub("/", " / ");
      pmaterial = $0;
      next;
    }

    /<td>Color:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pcolor = $0;
      next;
    }

    /<td>Inner:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pinner = $0;
      next;
    }

    /<td>Master:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pmaster = $0;
      next;
    }

    /<td>Unit:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      punit = $0;
      next;
    }

    /<td>Height:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pheight = $0;
      next;
    }

    /<td>Length:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      plength = $0;
      next;
    }

    /<td>Width:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pwidth = $0;
      next;
    }

    /<td>Weight:</ {
      getline;
      gsub("^.*<td[^>]*>", "");
      gsub("</td>.*$", "");
      gsub("[\t ]+", " ");
      gsub("(^ | $)", "");
      pweight = $0;
      next;
    }


    /.media.images.HiRes.[0-9]+/ {

         if(1 > pid) {
           pid = FILENAME;
           gsub("[.].*$", "", pid);
           gsub("^.*/", "", pid);
           pid = pid+0;
         }

         gsub("^.*src=.", "");
         gsub("\".*$", "");
         gsub("[?].*$", "");
         img = tolower($0);
         gsub("^.*/", "", img);
         idx = img;
         gsub("[^0-9].*$", "", idx);
         il = idx % 10;
         ifile= "/wp-content/uploads/import01/" il "/" idx "/" img;
         if(1 == index(img, pid ".") || 1 == index(img, pid "-")) {
           if(!_[img]++) {
             pimg[icnt++] = ifile;
           }
         }

      next;
    }

    /<span>This product is in stock</ {
      pinstock++;
    }

    /<li class="nav-item">/ {
      navflag++;
    }


    /<[/]html/ {

      pcat = URL;
      gsub("/$", "", pcat);
      gsub("/[^/]*$", "", pcat);
      gsub("^.*/", "", pcat);

      print "-----";
      print "id",       pid;
      print "title",    ptitle;
      print "cat",      pcat;
      print "sprice",   psprice;
      print "rprice",   prprice;
      print "instck",   pinstock;
      print "matrl",    pmaterial;
      print "color",    pcolor;
      print "inner",    pinner;
      print "master",   pmaster;
      print "unit",     puni;
      print "height",   pheight;
      print "lenght",   plength;
      print "width",    pwidth;
      print "weight",   pweight;

      for(q = 0 ; 10 > q; q++) {
        print "pic" q, pimg[q];;
      }

      print "url",   URL;

      print "end";

    }


  '  $1

#-#
