function _git_dirty
  set -l status_info (command git status -s -uno ^/dev/null)
  [ $status = 0 ]; or return 1
  [ $status_info ]
end
function _git_status
  set -l branch_name (command git rev-parse --abbrev-ref HEAD ^/dev/null)
  test $status -ne 0; and return  # not in a git repo
  if _git_dirty
    set_color ff6c5d red
  else
    set_color 6291ff white
  end
  echo -n $branch_name
  set_color brblack
  echo -n ':'
end
function _exit_code
  set -l exit_code $status
  if test "$exit_code" -ne 0
    echo -n (set_color ff6c5d red)'⏎ '
  end
end
function fish_right_prompt
  _exit_code
  set_color brblack
  echo -n '('
  _git_status
  set_color 6291ff white
  echo -n (prompt_pwd)
  set_color brblack
  echo -n ')'
end
