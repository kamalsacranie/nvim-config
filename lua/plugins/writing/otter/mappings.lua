---@type Keymap[]
return {
    { "n", "gS",         require("otter").ask_document_symbols },
    { "n", "gd",         require("otter").ask_definition },
    { "n", "gD",         require("otter").ask_type_definition },
    { "n", "K",          require("otter").ask_hover },
    { "n", "gr",         require("otter").ask_references },
    { "n", "<leader>lr", require("otter").ask_rename },
    { "n", "<leader>lf", require("otter").ask_format }
}
