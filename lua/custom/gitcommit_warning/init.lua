local M = {}

function M.setup()
  local ns_id = vim.api.nvim_create_namespace("GitCommitWarning")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
      local function update()
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

        -- Highlight subject line if too long
        local subject = lines[1] or ""
        if #subject > 50 then
          vim.api.nvim_buf_add_highlight(0, ns_id, "Error", 0, 50, -1)
        end

        -- Highlight body lines if too long
        for i = 2, #lines do
          local line = lines[i] or ""
          if #line > 72 then
            vim.api.nvim_buf_add_highlight(0, ns_id, "Error", i - 1, 72, -1)
          end
        end
      end

      update()

      vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        buffer = 0,
        callback = update,
      })
    end,
  })
end

return M
