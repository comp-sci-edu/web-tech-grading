# installation and setup of grading commands

function install-grading-tools {
  # TODO ensure homebrew is installed
  # TODO ensure cargo is installed
  # TODO ensure npm is installed
  brew install rustup-init
  brew install bat ripgrep htmlq gron npm exiftool
  cargo install hck extract huniq mlc
  cargo install qsv --features lua,foreach
  npm install -g html-validate hint htmlhint prettier stylelint stylelint-config-standard
}

# html grading

function grade-html-validity {
  html-validate .
}

function grade-html-error-counts {
  html-validate -f text . \
  | extract 'error \[(.+)\]' \
  | huniq -cS
}

function grade-html-error-table {
  html-validate . \
  | rg '^ +' \
  | rg -v '^ + https?:' \
  | choose -f ' {2,}' -o "\t" -2: \
  | huniq -cS \
  | csview -Ht -s None
}

# NOTE: webhint's json output is not valid json
function grade-html-webhints {
  hint -f summary .
}

function grade-html-hints {
  htmlhint -f compact **/*.html \
  | extract '\((.+?)\)[ \t]*$' \
  | huniq -cS
}

function grade-comments {
  rg -iF '<!--' **/*.html
}

function grade-hierarchy {
  htmlq -f ${*:-index.html} 'h1,h2,h3,h4,h5,h6' \
  | pandoc -f html -t gfm \
  | rg -v '^\s*$'
}

# link and source grading

function grade-alt-attrs {
  bat **/*.html | htmlq img -a alt
}

function grade-link-count {
  bat **/*.html | htmlq a -a href | huniq -cS
}

function grade-link-targets {
  bat **/*.html | htmlq a -a target
}

function grade-img-sources {
  bat **/*.html | htmlq img -a src | huniq -cS
}

function grade-img-remote-links {
  bat **/*.html \
  | htmlq img -a src \
  | rg '^[:space:]*https?://'
  # | huniq -cS
}

# this ignores SVG files since size doesn't mean the same thing for vector formats
function grade-img-sizes {
  exiftool -csv -FileSize -ImageWidth -ImageHeight -ext jpeg -ext jpg -ext png -ext gif -ext webp -r ${1:-.} \
  | qsv lua map MPixels 'ImageHeight * ImageWidth' \
  | xsv sort -NRs MPixels \
  | csview
}

function grade-svg-usage {
  rg -iF 'svg' **/*.html
}

function grade-raster-usage {
  rg -i '(?:png|jpe?g|gif|webm)' **/*.html
}

function grade-link-validity {
  mlc --match-file-extension
}

function grade-link-validity-local {
  mlc --no-web-links --match-file-extension
}

# css grading

# NOTE: I think html-validate and webhint catch this if configured
function grade-styles-embedded {
  for page in **/*.html
  do
    echoc -f info "$page"
    htmlq -f "$page" style | sed "s/^/$indent/"
    # TODO: need to make sure that this excludes embedded SVGs
    htmlq -f "$page" -a style '*' | sed "s/^/$indent/"
  done
}

function grade-css-validity {
  stylelint **/*.css
}

function grade-css-error-counts {
  stylelint -f json **/*.css \
  | gron \
  | rg '\.rule' \
  | hck -d '=' -f 2 \
  | extract '"(.*)"' \
  | huniq -cS
}

function grade-css-dryness {
  prettier **/*.css \
  | huniq -cS \
  | rg -v '^1 ' \
  | rg -v '^\d+ +\}? *$'
}

function grade-css-dryness-malformed {
  bat **/*.css \
  | extract '^[ \t]*(.+)[ \t]*$' \
  | huniq -cS \
  | rg -v '^1 ' \
  | rg -v '^\d+ +[}{]? *$'
}

# grade formatting

function grade-formatting {
  local misformatted="$1"
  prettier "$misformatted" > "${misformatted}.formatted"
  diff -bu "$misformatted" "${misformatted}.formatted" > "${misformatted}.diff"
}

function grade-formatting-diffs {
  prettier --list-different ${*:-.}/**/*.{html,css} \
  | env_parallel --env grade-formatting grade-formatting
}

function grade-formatting-view {
  cat **/*.diff | delta
}

function grade-formatting-cleanup {
  rm -v *.{html,css}.{diff,formatted}
}

# additional tools

function grade-tag-per-page {
  local attribute show_help
  zparseopts -D \
    a:=attribute \
    h=show_help \
    -help=show_help

  if [[ -n $show_help ]] then
    cat <<END_OF_HELP
  -a, attribute   return only the contents of this attribute
                  NOTE: attributes must come before other args

  -h, --help      help (this text)
END_OF_HELP
    return 0
  fi

  # echoc -f warn "attr: $attribute"

  # TODO: add arg handling for attributes
  local tag=$1
  local indent='  '
  # last sed command is for indentation
  # fd .html | parallel -j 1 "echo {}; htmlq -f {} $tag | sed \"s/^/$indent/\""
  for page in **/*.html
  do
    echoc -f info "$page"
    htmlq -f "$page" $tag $attribute | sed "s/^/$indent/"
  done
}
