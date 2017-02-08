function _git_branch
  command git rev-parse --abbrev-ref HEAD
end
function _git_dirty
  test -n (command git status -s -uno ^/dev/null)
end
function fish_right_prompt
  set -l git_branch (_git_branch)
  if test $status -eq 0
    echo -n (set_color normal)'('
    if _git_dirty
      echo -n (set_color ff6c5d red)
    else
      echo -n (set_color 6291ff white)
    end
    echo -n $git_branch(set_color normal)')'
  end
end
