return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- O tema deve carregar no início
    priority = 1000, -- Garante que carregue antes de outros plugins
    opts = {
      style = "storm", -- Opções: "storm", "night", "moon", "day"
      transparent = true, -- Ativa transparência se você gostar
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
