#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Railscasts scheme by Ryan Bates (http://railscasts.com)

# This script doesn't support linux console (use 'vconsole' template instead)
if [ "${TERM%%-*}" = 'linux' ]; then
    return 2>/dev/null || exit 0
fi

colorchange Dark

# color00="1c/26/2a" # Base 00 - Black
# color01="dc/5c/60" # Base 08 - Red
# color02="a0/cf/6e" # Base 0B - Green
# color03="ff/df/63" # Base 0A - Yellow
# color04="54/a4/f3" # Base 0D - Blue
# color05="c1/7c/cf" # Base 0E - Magenta
# color05="c1/7c/cf" # Base 0E - Magenta
# color06="70/d7/e5" # Base 0C - Cyan
# color07="3c/4c/54" # Base 05 - White
# color08="29/35/3b" # Base 03 - Bright Black

color00="3c/4c/54" # Base 00 - Black
color01="ff/53/70" # Base 08 - Red
color02="c3/e8/8d" # Base 0B - Green
color03="ff/cb/6b" # Base 0A - Yellow
color04="82/aa/ff" # Base 0D - Blue
color05="c7/92/ea" # Base 0E - Magenta
color06="89/dd/ff" # Base 0C - Cyan
color07="3c/4c/54" # Base 05 - White
color08="56/6f/7c" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="ee/ff/ff" # Base 07 - Bright White
color16="cc/78/33" # Base 09
color17="bc/94/58" # Base 0F
color18="27/29/35" # Base 01
color19="3a/40/55" # Base 02
color20="d4/cf/c9" # Base 04
color21="f4/f1/ed" # Base 06
color_foreground="ee/ff/ff" # Base 05
color_background="26/32/38" # Base 00
color_cursor="ff/cc/00" # Base 05

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template='\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\'
  printf_template_var='\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\'
  printf_template_custom='\033Ptmux;\033\033]%s%s\033\033\\\033\\'
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template='\033P\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033P\033]%d;rgb:%s\033\\'
  printf_template_custom='\033P\033]%s%s\033\\'
else
  printf_template='\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033]%d;rgb:%s\033\\'
  printf_template_custom='\033]%s%s\033\\'
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  printf $printf_template_custom Pg eeffff # forground
  printf $printf_template_custom Ph 263238 # background
  printf $printf_template_custom Pi ee2b2a # bold color
  printf $printf_template_custom Pj eeffff # selection color
  printf $printf_template_custom Pk 536d7b # selected text color
  printf $printf_template_custom Pl ffcc00 # cursor
  printf $printf_template_custom Pm 263238 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor
