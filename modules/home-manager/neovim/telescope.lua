require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call load_extension
-- somewhere after setup function
require('telescope').load_extension('fzf')
