#!/bin/sh

# Materiterm: Material for iTerm
# Material Pale scheme by Seth Wright (https://github.com/asethwright)

# Based on the base16-shell template
# by Chris Kempson (https://github.com/chriskempson)

# Colors by Mattia Astorino (https://github.com/equinusocio)
# from the Sublime Text 3 Material Theme

color00="29/2D/3E" # Base 00 - Black
color01="FF/53/70" # Base 08 - Red
color02="C3/E8/8D" # Base 0B - Green
color03="FF/CB/6B" # Base 0A - Yellow
color04="82/AA/FF" # Base 0D - Blue
color05="C7/92/EA" # Base 0E - Magenta
color06="89/DD/FF" # Base 0C - Cyan
color07="46/4B/5D" # Base 05 - White
color08="82/8E/D5" # Base 03 - Bright Black
color09="f0/71/78" # Base 08 - Bright Red
color10="FF/53/70" # Base 0B - Bright Green
color11="b2/cc/d6" # Base 0A - Bright Yellow
color12="bb/80/b3" # Base 0D - Bright Blue
color13="ab/79/67" # Base 0E - Bright Magenta
color14="3F/44/64" # Base 0C - Bright Cyan
color15="8F/93/A2" # Base 07 - Bright White
color16="f0/71/78" # Base 09 (pink)
color17="FF/53/70" # Base 0F (orange)
color18="b2/cc/d6" # Base 01 (pale blue)
color19="bb/80/b3" # Base 02 (violet)
color20="ab/79/67" # Base 04 (brown)
color21="2f/3f/47" # Base 06
color_foreground="8F/93/A2" # Base 05
color_background="1E/1F/22" # Base 00
color_cursor="FF/CB/6B" # Base 05

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
  printf $printf_template_custom Pg 8f93a2 # forground
  printf $printf_template_custom Ph 1e1f22 # background
  printf $printf_template_custom Pi ee2b2a # bold color
  printf $printf_template_custom Pj 292B34 # selection color
  printf $printf_template_custom Pk 8f93a2 # selected text color
  printf $printf_template_custom Pl ffcb6b # cursor
  printf $printf_template_custom Pm 8f93a2 # cursor text
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

# it2setcolor tab 292d3e

# add a dotfile that vim can read when loading up
# will automatically set the color scheme to materitermpale
echo "if !exists('g:colors_name') || g:colors_name != 'materitermdarkmode'\ncolorscheme materitermdarkmode\nendif" > ~/.vimrc_background
