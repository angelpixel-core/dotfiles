return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Vaults_Backup/Harvis",
        },
        {
          name = "work",
          path = "~/Vaults_Backup/Harvis",
        },
      },
      wiki_link_func = "use_alias_only",
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
    },
  },
}
