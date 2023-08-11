-- Telescope
local wk = require("which-key")

wk.register({
    ["<leader>"] = {
        f = {
            name = "Files",
            f = { "<cmd>Telescope find_files<cr>", "Find Files" }
        },
        p = {
            v = { "<cmd> Ex <cr>", "File browser" }
        },
        t = {
            name = "Flutter",
            d = {"<cmd> FlutterDevices <cr>", "Flutter: Show devices" },
            c = {"<cmd> Telescope flutter commands <cr>", "Flutter: commands" }
        }
    }
})
