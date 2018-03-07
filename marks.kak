set-face MarksBackground rgb:aaaaaa
set-face MarksForeground red+b

#declare-option range-specs marks_specs

define-command show-marks -docstring 'show marks' %{
  # from previous call
  hide-marks
  declare-option -hidden str-list marks_list
  add-highlighter window fill MarksBackground
  %sh{
    for reg in {'caret',{a..z}}; do
      reg_content='%reg{'$reg'}'
      echo "_show-mark-impl $reg $reg_content"
    done
  }
  echo "marks highlighted: %opt{marks_list}"
}

define-command hide-marks -docstring 'hide marks' %{
  try %{ remove-highlighter window/fill_MarksBackground }
  try %{ unset-option window marks_list }
  %sh{
    for reg in {'caret',{a..z}}; do
      echo "try %{ remove-highlighter window/replace_ranges_mark_specs_$reg }"
    done
  }
}

define-command _show-mark-impl -hidden -params 2 %{ %sh{
  # marks are saved as selections_descs@buffer_name%timestamp
  descs=$(echo $2 | sed -n 's/\(.*\)@\(.*\)%.*/\1/p')
  buf_file=$(echo $2 | sed -n 's/\(.*\)@\(.*\)%.*/\2/p')
  timestamp=$(echo $2 | sed -n 's/\(.*\)@\(.*\)%\(.*\)/\3/p')

  if [ -n "$descs" ] && [ "$buf_file" == "$kak_buffile" ]; then
    opt="mark_specs_$1"
    mark=$1
    # fullname is needed for legal option name, but visually we want ^
    if [ "$mark" == 'caret' ]; then
      mark='^'
    fi
    # we need to have 1 hl per register to keep them in sync individually ala update-option
    echo "declare-option range-specs $opt"
    echo "add-highlighter window replace-ranges $opt"
    echo "set-option window $opt $timestamp"
    echo "set-option -add window marks_list $mark"

    printf '%s\n' "$descs" | tr ':' '\n' |
    while read desc; do
      IFS=',' read -ra b <<< "$desc"
      anchor="${b[0]}"
      cursor="${b[1]}"
      # only highlight boundaries (multiline overstrike would a bit more complicated)
      echo "set-option -add window $opt $anchor,$anchor|{MarksForeground}$mark"
      echo "set-option -add window $opt $cursor,$cursor|{MarksForeground}$mark"
    done
  fi
} }
