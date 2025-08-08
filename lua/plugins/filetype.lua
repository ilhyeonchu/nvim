-- plugins/filetype.lua
return {
    "nathom/filetype.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        overrides = {
            extensions = {
                tl = "teal",
            },
            literal = {
                ["Jenkinsfile"] = "groovy",
            },
            complex = {
                [".*%.env%..+"] = "sh",
            },
        },
    },
    config = function(_, opts)
        require("filetype").setup(opts)
    end,
}
