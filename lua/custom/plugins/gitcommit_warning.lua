return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/custom/gitcommit_warning",
    name = "gitcommit_warning",
    lazy = false,
    config = function()
      require("custom.gitcommit_warning").setup()
    end,
  },
}
