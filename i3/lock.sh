#!/bin/bash

####################################################################
#                                #                                 #
#             i3lock++           #        Available effects        #
#                                #                                 #
# Dependencies:                  #   -  blur                       #
#    - imagemagick               #   -  pixel                      #
#    - i3lock                    #   -  gray                       #
#                                #   -  sepia                      #
# Usage:                         #   -  charcoal                   #
#    i3lock++ [EFFECT]           #   -  paint                      #
#                                #   -  spread                     #         
#                                #   -  vignette                   #
#                                #                                 #
#                                #                                 #
####################################################################

IMG='/tmp/i3lock.png'            # path of screenshot
SCT='import -silent -window root'        # screenshot command

              ##########################################
              #                                        #
              #               EFFECTS                  #
              #                                        #
              # Edit variables to change effect result #
              #                                        #
              #                                        #
              ##########################################

BLUR="-blur 2x3" 
PIXEL="-scale 25% -scale 400%" 
GRAY="-colorspace Gray -gamma 0.7"
SEPIA="-sepia-tone 80%"
CHARCOAL="-charcoal 5 "
PAINT="-paint 1"
SPREAD="-interpolate nearest -virtual-pixel mirror -spread 5"
VIGNETTE="-background black -vignette 0x5" 

# Take screenshot
$SCT $IMG

# Choose the effect
case "$1" in
    
    blur)
        convert $IMG $BLUR $IMG ;;

    pixel)
        convert $IMG $PIXEL $IMG ;;
    
    gray)
        convert $IMG $GRAY $IMG ;;

    sepia)
        convert $IMG $SEPIA $IMG ;;
    
    charcoal)
        convert $IMG $CHARCOAL $IMG ;;
    
    paint)
        convert $IMG $PAINT $IMG ;;
    
    spread)
        convert $IMG $SPREAD $IMG ;;
    
    vignette)
        convert $IMG $VIGNETTE $IMG ;;

    *) 
        echo -ne "Usage : i3lock++ [EFFECT]\n"
        rm -f $IMG
        exit 1 ;; # exit with error 
esac

# Lock with screenshot
i3lock -i $IMG
rm  -f $IMG
