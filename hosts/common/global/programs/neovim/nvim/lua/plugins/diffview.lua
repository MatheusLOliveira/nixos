return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>gv", function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end, { desc = "Diff View" })
    end,
  },
}
