return {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    -- For `nvim-treesitter` users.
    priority = 49,

    dependencies = {
        -- For blink.cmp's completion
        -- source
        "saghen/blink.cmp",
        "nvim-tree/nvim-web-devicons"
    }
}
