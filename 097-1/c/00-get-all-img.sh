#!/bin/bash

#
#
#

  gawk '

    /HiRes/ {
       if($0 ~ /<img/) {
         gsub("^.*src=.", "");
         gsub("\".*$", "");
         gsub("[?].*$", "");
         img = tolower($0);
         gsub("^.*/", "", img);
         idx = img;
         gsub("[^0-9].*$", "", idx);
         il = idx % 10;
         if(!_[img]++) {

           ifile= "/DEV/097-pictures/wp-content/uploads/import01/" il "/" idx "/" img;

           if(!testfile(ifile)) {
             print "./get-img.sh https://www. .... .com" $0, img, idx, il;
           }

         }
       }
    }

    function testfile(fn,   r) {
      r = 0;
      if(0 < (getline < fn)) {
        r++;
        close(fn);
      }
      return r;
    }



  '  /DEV/097/prod/*.html | sort -R > 02-get-image.sh

#

