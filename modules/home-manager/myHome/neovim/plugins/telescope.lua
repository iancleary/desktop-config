local builtin = require("telescope.builtin")
local setup = require("telescope.setup")

setup.pickers = {
  layout_config = {
	width = 0.9,
	height = 0.9,
  },
  find_files = {
	hidden = true,
  },
  sorting_strategy = "ascending",
  mappings = {
	i = {
	  ["<esc>"] = builtin.close,
	  ["<C-j>"] = builtin.move_selection_next,
	  ["<C-k>"] = builtin.move_selection_previous,
	},
  },
}


vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Open file picker" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Open buffer picker" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Open help tags picker" })
vim.keymap.set("n", "<leader>c", builtin.commands, { desc = "Open help tags picker" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Open live grep" })

vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
