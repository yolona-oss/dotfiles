local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
        return
end

require("base46").load_highlight "treesitter"

local options = {
        ensure_installed = {
                "tsx",
                "toml",
                "json",
                "yaml",
                "css",
                "html",
                "lua",
                "bash",
                "cpp"
        },

        autotag = {
                enable = true,
        },

        highlight = {
                enable = true,
                use_languagetree = true,
        },

        indent = {
                enable = true,
        },

        -- nt_cpp_tools = {
        --         enable = true,
        --         preview = {
        --                 quit = 'q', -- optional keymapping for quit preview
        --                 accept = '<tab>' -- optional keymapping for accept preview
        --         },
        --         header_extension = 'hpp', -- optional
        --         source_extension = 'cpp', -- optional
        --         custom_define_class_function_commands = { -- optional
        --                 TSCppImplWrite = {
        --                         output_handle = require'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
        --                 }
        --                 --[[
        --     <your impl function custom command name> = {
        --         output_handle = function (str, context) 
        --             -- string contains the class implementation
        --             -- do whatever you want to do with it
        --         end
        --     }
        --     ]]
        --         }
        -- }
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

treesitter.setup(options)
