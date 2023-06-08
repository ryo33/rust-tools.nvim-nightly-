# rust-tools.nvim (nightly)

This is a customized fork of https://github.com/simrat39/rust-tools.nvim with unmerged feature request and bug fixes.

Please read below before using.

- I use this fork as daily driver for my works that mostly use Rust.
- I merge the pull-requests without my own review, and push to here if any appearant problem happens.
- If I find bugs or improvements, I'll provide notice or bug fix commit to the source pull-request.
- This fork may contain my own improvements and bug fixes not related to the pull-requests just for me.
- If the changes seem helpful to anyone other than me, I'll open pull-request to simrat39/rust-tools.nvim when the change is stabilized.
- If you find not merged one, feel free to open an issue.

# choice module from https://github.com/simrat39/rust-tools.nvim/pull/382
```lua
-- choice module you use to speed up setuptime
open = {
  crate_graph = true,
  expand_macro = true,
  external_docs = true,
  debuggables = true,
  hover_range = true,
  workspace_refresh = true,
  move_item = true,
  standalone = true,
  dap = true,
  parent_module = true,
  runnables = true,
},
