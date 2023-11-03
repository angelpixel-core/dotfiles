return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signcolumn = true,
		numhl = true,
		max_file_length = 10000,

    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	},
}
