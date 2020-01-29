" removes the trailing spaces after a snippet
function! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunction

iabbrev vuetmpl <template><CR><div><CR><CR></div><CR></template><CR><CR><script><CR>export default {};<CR></script><CR><CR><style scoped lang="scss"></style><C-R>=Eatchar('\s')<CR><Esc>10ki
iabbrev lipsum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer diam augue, egestas quis, aliquam ut, venenatis ut, quam. Quisque ut augue. Integer non neque a lectus venenatis fermentum. Morbi quis eros nec elit molestie vehicula. Integer nunc lacus, sodales posuere, rutrum quis, blandit at, mi. Vivamus imperdiet wisi vel mauris. Morbi mattis ante non metus. Sed turpis dui, fermentum ut, aliquam eget, vulputate ullamcorper, pede. Nam non dolor. Etiam lobortis, urna id bibendum convallis, ligula augue auctor eros, a dictum sapien mi a tellus. Proin vel justo. Nunc malesuada turpis a sapien.<C-R>=Eatchar('\s')<CR>
iabbrev fontawesome import { library } from '@fortawesome/fontawesome-svg-core';<CR>import { faPlusCircle } from '@fortawesome/free-solid-svg-icons';<CR>import { FontAwesomeIcon as Icon } from '@fortawesome/vue-fontawesome';<CR><CR>library.add(faPlusCircle);
