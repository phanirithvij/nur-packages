{ lazygit }:
lazygit.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [
    # https://github.com/jesseduffield/lazygit/issues/5945
    ./worktrees-search-branch.patch
  ];
})
