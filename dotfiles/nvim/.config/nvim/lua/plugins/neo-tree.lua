return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        visible = true,
      },
    },
    event_handlers = {
      -- {
      --   event = "after_render",
      --   handler = function()
      --     local state = require("neo-tree.sources.manager").get_state("filesystem")
      --     if not require("neo-tree.sources.common.preview").is_active() then
      --       state.config = { use_float = false } -- or whatever your config is
      --       state.commands.toggle_preview(state)
      --     end
      --   end,
      -- },
    },
  },
}
