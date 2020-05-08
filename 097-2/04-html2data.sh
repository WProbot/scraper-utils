#!/bin/bash

#
#  html2data.sh  SABTCU
#


  gawk '

#-----------------------------------------------
#-----------------------------------------------

    BEGIN {
#     debug++;
      OFS = "\t";
      HUF = 415;
    }

#-----------------------------------------------

    END {
      print "------------";
      if(debug) {
        print "------------" > "debug.log";
      }
    }

#-----------------------------------------------
#-----------------------------------------------

    !_[FILENAME]++ {

      print "------------";
      if(debug) {
        print "------------" > "debug.log";
      }

      id = FILENAME;
      gsub("^.*/",   "", id);
      gsub("[.].*$", "", id);

      delete D;

      D["id"] = id;

    }

#-----------------------------------------------

    /<title>/ {
      D["title"] = _notag($0);
      next;
    }

#-----------------------------------------------

    /<link rel="canonical"/ {

      url =  _href($0)
      D["url"] = url;

      url = _rls(_rls(_rls(url)));
      name = _rrs(url);
      if(name) {
        D["name"] = name;
        if(0 < index(substr(url, 1, length(url)-1), "/")) {
          D["cat1"] = _clcat(name);
        }
      }

      url = _rls(url);
      name = _rrs(url);
      if(name) {
        D["name"] = name;
        if(0 < index(substr(url, 1, length(url)-1), "/")) {
          D["cat2"] = _clcat(name);
        }
      }

      url = _rls(url);
      name = _rrs(url);
      if(name) {
        D["name"] = name;
        if(0 < index(substr(url, 1, length(url)-1), "/")) {
          D["cat3"] = _clcat(name);
        }
      }

      url = _rls(url);
      name = _rrs(url);
      if(name) {
        D["name"] = name;
      }

      next;

    }

#-----------------------------------------------

    0 && /<meta Name="keywords"/ {
      D["keyw"] = _clean(_clcat(_content($0)));
      next;
    }

#-----------------------------------------------

    /<div class="productImageGroupDetails row">/ , /<div class="clear">/ {

      img = "";

      if($0 ~ /<img.*Images/) {
        img =  _src($0)
        if(debug) {
          print img > "debug.log";
        }
      }

      if($0 ~ /href.*Images/) {
        img =  _href($0)
        if(debug) {
          print img > "debug.log";
        }
      }

      if(img ~ /xlarge/ && !_[img]++) {
        D["_img" ++D["_imgc"]] = img;
      }

    }

#-----------------------------------------------

    /<div class="product-code">/ {
      tmp = _notag($0);
      gsub("^[^:]*:", "", tmp);
      D["oid"] = _clean(tmp);
      next;
    }

#-----------------------------------------------

  /<div class="item-property">Barcode:/ {
      tmp = _notag($0);
      gsub("^[^:]*:", "", tmp);
      D["barc"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="product-rrp-price">/ {
      tmp = _notag($0);
      gsub("^[^:]*:", "", tmp);
      D["rrp"]   = _clean(tmp);
      D["rrp_h"] = _tohuf(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="product-price">/ {
      tmp = _notag($0);
      gsub("^[^:]*:", "", tmp);
      D["price"]   = _clean(tmp);
      D["price_h"] = _tohuf(tmp);
      next;
  }

#-----------------------------------------------

  /<span class="product-stock">/ {
      tmp = _notag($0);
      gsub("^[^:]*:", "", tmp);
      D["stock"] = _clean(tmp) + 0;
      next;
  }

#-----------------------------------------------

  /<div id="TabProductInfo">/ {
      getline
      tmp = _notag($0);
      D["desc"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="attribname">Collection</ {
      gsub("<div class=.attribname.>[^<]*</div>", " ");
      tmp = _notag($0);
      D["coll"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="attribname">Colour</ {
      gsub("<div class=.attribname.>[^<]*</div>", " ");
      tmp = _notag($0);
      D["color"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="attribname">Dimensions</ {
      gsub("<div class=.attribname.>[^<]*</div>", " ");
      tmp = _notag($0);
      D["dim"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<div class="attribname">Material</ {
      gsub("<div class=.attribname.>[^<]*</div>", " ");
      tmp = _notag($0);
      D["matrl"] = _clean(tmp);
      next;
  }

#-----------------------------------------------

  /<span class="product-limit">/ {
      tmp = _clean(_notag($0));
      gsub("^.* ", "", tmp);
      D["limit"] = _clean(tmp);
      next;
  }

#-----------------------------------------------
#-----------------------------------------------

    /<[/]html>/ {

      for(q in D) {
        print id, q, D[q];
      }

      ic=D["_imgc"];
      nm=D["name"];
      if(ic) {
        for(i = 0; i < ic; i++) {
          iorg = D["_img" i+1];
          if(!i) {
            inew = nm ".jpg";
          } else {
            inew = nm "-" i+1 ".jpg";
          }
          print id, "img" i+1, inew;
          print iorg, inew > "xx-inage.txt";
        }
      }

    }

#-----------------------------------------------
#-----------------------------------------------

    function _clean(i,  s) {
      s = i;
      gsub("&nbsp;",     " ", s);
      gsub("&pound;",    " ", s);
      gsub("[\t\n\r ]+", " ", s);
      gsub("(^ | $)",    "",  s);
      return s;
    }

#-----------------------------------------------

    function _notag(i,  s) {
      s = i;
      gsub("<[^>]*>",    " ", s);
      return _clean(s);
    }

#-----------------------------------------------

    function _href(i,  s) {
      s = i;
      gsub("^.*href=\"", "",  s);
      gsub("\".*$",      "",  s);
      return _clean(s);
    }

#-----------------------------------------------

    function _content(i,  s) {
      s = i;
      gsub("^.*[Cc]ontent=\"", "",  s);
      gsub("\".*$",      "",  s);
      return _clean(s);
    }

#-----------------------------------------------

    function _rls(i,  s) {
      s = i;
      gsub("^[^/]*/", "",  s);
      return s;
    }

#-----------------------------------------------

    function _rrs(i,  s) {
      s = i;
      gsub("/.*$", "",  s);
      return s;
    }

#-----------------------------------------------

    function _clcat(i,  s) {
      s = i;
      gsub("%C3%A9", "e",  s);
      gsub("&#32;",  " ",  s);
      gsub(" ",      "_",  s);
      return tolower(s);
    }

#-----------------------------------------------

    function _src(i,  s) {
      s = i;
      gsub("^.*src=\"", "",  s);
      gsub("\".*$",      "",  s);
      return _clean(s);
    }

#-----------------------------------------------

    function _tohuf(i) {
      return int(_clean(i) * HUF + 0.5);
    }

#-----------------------------------------------
#-----------------------------------------------

  ' prod/*.html > xx-out.txt


#-#
