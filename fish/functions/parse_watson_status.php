<?php

$re = '/Project (.*) started(.*)/m';
$str = shell_exec("WATSON_DIR=/Users/seth/Library/Mobile\ Documents/com~apple~CloudDocs/Swarm/Seth /usr/local/bin/watson status");

preg_match_all($re, $str, $matches, PREG_SET_ORDER, 0);

if ($matches) {
  echo trim(preg_replace('/\s\s+/', '', $matches[0][1]));
} else {
  echo str_replace(" started.", "", $str);
}
