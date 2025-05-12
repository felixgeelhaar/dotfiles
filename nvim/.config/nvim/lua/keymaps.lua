-- Clear search highlights
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Exit terminal mode with a more reliable shortcut
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Enforce vim navigation habits
vim.keymap.set("n", "<left>", '<cmd>echo "Use the vim keys"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use the vim keys"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use the vim keys"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use the vim keys"<CR>')

-- Window navigation and management
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Editing improvements
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left and Keep Selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right and Keep Selection" })

-- Application commands
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- [B]uffer management
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>b`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
vim.keymap.set(
	"n",
	"<leader>bc",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Quickfix and location list
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- [F]ile operations
vim.keymap.set("n", "<leader>fn", "<cmd>new<cr>", { desc = "New File" })

-- [L]azy plugin management
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- [F]ind [U]sages and inspection
vim.keymap.set("n", "<leader>fui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>fuI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Plugin shortcuts
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- ============================================================================
-- AI ASSISTANT KEYMAPS
-- ============================================================================
vim.keymap.set(
	"n",
	"<leader>ai",
	"<cmd>CodeCompanionActions<cr>",
	{ desc = "AI Actions", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>at",
	"<cmd>CodeCompanionChat Toggle<cr>",
	{ desc = "Toggle AI Chat", noremap = true, silent = true }
)
vim.keymap.set(
	"v",
	"<leader>aa",
	"<cmd>CodeCompanionChat Add<cr>",
	{ desc = "Add to AI Chat", noremap = true, silent = true }
)

-- ============================================================================
-- LSP KEYMAPPINGS
-- ============================================================================

-- Core LSP navigation (memorable mnemonic: "g for go to")
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set(
	"n",
	"gr",
	"<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>",
	{ desc = "Go to References" }
)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })

-- Core documentation/information
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Symbol Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- [C]ode operations with leader prefixes
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format Document" })

-- LSP info and management
vim.keymap.set("n", "<leader>ci", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
vim.keymap.set("n", "<leader>cR", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })

-- Symbol operations
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>cS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })

-- Diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>cl", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Buffer Diagnostics List" })
vim.keymap.set("n", "<leader>cL", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics List" })

-- Diagnostic navigation
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
vim.keymap.set("n", "]h", diagnostic_goto(true, "HINT"), { desc = "Next Hint" })
vim.keymap.set("n", "[h", diagnostic_goto(false, "HINT"), { desc = "Prev Hint" })
vim.keymap.set("n", "]i", diagnostic_goto(true, "INFO"), { desc = "Next Info" })
vim.keymap.set("n", "[i", diagnostic_goto(false, "INFO"), { desc = "Prev Info" })

-- [W]orkspace management
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
vim.keymap.set("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List Workspace Folders" })

-- Inlay hints toggle
vim.keymap.set("n", "<leader>cI", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- Code folding
vim.keymap.set("n", "<leader>cz", "za", { desc = "Toggle Fold", remap = true })
vim.keymap.set("n", "<leader>cZ", "zA", { desc = "Toggle All Folds", remap = true })
vim.keymap.set("n", "<leader>cf", "zf", { desc = "Create Fold", remap = true })

-- [S]earch operations
vim.keymap.set("n", "<leader>ss", function()
	require("telescope.builtin").lsp_document_symbols()
end, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>sw", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "Workspace Symbols" })
vim.keymap.set("n", "<leader>sg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").find_files()
end, { desc = "Search Files" })

-- Add cheatsheet command
vim.api.nvim_create_user_command("Cheatsheet", function()
	require("telescope.builtin").keymaps({})
end, { desc = "Show keymaps cheatsheet" })
vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Keymaps Cheatsheet" })

-- ============================================================================
-- FILE TREE KEYMAPS (Neo-tree)
-- ============================================================================
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer (toggle)" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status toggle<CR>", { desc = "Git Status Explorer" })

-- ============================================================================
-- FUZZY FINDER KEYMAPS (Telescope)
-- ============================================================================
local builtin = require("telescope.builtin")
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files theme=dropdown previewer=false<cr>",
	{ desc = "Find Files" }
)
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find String" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word Under Cursor" })
vim.keymap.set("x", "<leader>fs", builtin.grep_string, { desc = "Find Selection" })
vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "Find Modified File" })
vim.keymap.set(
	"n",
	"<leader>fb",
	"<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown previewer=false<cr>",
	{ desc = "Find Buffers" }
)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
vim.keymap.set(
	"n",
	"<leader>fo",
	"<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>",
	{ desc = "Find Old Files" }
)
vim.keymap.set("n", "<leader>fm", function()
	require("telescope").extensions.notify.notify()
end, { desc = "Find Messages" })

-- ============================================================================
-- PROJECT MANAGEMENT
-- ============================================================================
vim.keymap.set("n", "<leader>fp", function()
	require("telescope.builtin").find_files({
		prompt_title = "Projects",
		cwd = "~/projects", -- Change to your projects directory
		find_command = { "fd", "--type", "d", "--max-depth", "1" },
	})
end, { desc = "Find Projects" })

-- ============================================================================
-- SCRATCH BUFFER
-- ============================================================================
vim.keymap.set("n", "<leader>bs", function()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "Scratch-" .. os.date("%Y-%m-%d-%H:%M"))
	vim.api.nvim_set_current_buf(buf)
	vim.bo[buf].filetype = "markdown" -- or your preferred scratch buffer type
	vim.notify("Scratch buffer created", "info", { title = "Buffer" })
end, { desc = "New Scratch Buffer" })

-- ============================================================================
-- NOICE KEYMAPS
-- ============================================================================
vim.keymap.set("n", "<leader>n", "", { desc = "[N]oice" })
vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })
vim.keymap.set("n", "<leader>nl", function()
	require("noice").cmd("last")
end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>nh", function()
	require("noice").cmd("history")
end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>na", function()
	require("noice").cmd("all")
end, { desc = "Noice All" })
vim.keymap.set("n", "<leader>nd", function()
	require("noice").cmd("dismiss")
end, { desc = "Dismiss All" })
vim.keymap.set("n", "<leader>nt", function()
	require("noice").cmd("pick")
end, { desc = "Noice Picker" })

-- ============================================================================
-- LSP SCROLL IN WINDOWS
-- ============================================================================
vim.keymap.set({ "i", "n", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true, desc = "Scroll Forward" })

vim.keymap.set({ "i", "n", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true, desc = "Scroll Backward" })

-- ============================================================================
-- NONE-LS KEYMAPS
-- ============================================================================
-- This is duplicated with your LSP keymaps, remove from none-ls.lua
-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })

-- ============================================================================
-- TREESITTER TEXTOBJECTS KEYMAPS
-- ============================================================================
-- These are configured in the treesitter setup, so we don't need to
-- duplicate them here, but documenting them for reference

-- ============================================================================
-- CODE MOVEMENT KEYMAPS
-- ============================================================================
-- Move selected text up/down/left/right with Shift+Alt+hjkl
vim.keymap.set("v", "<S-A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "<S-A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })
vim.keymap.set("v", "<S-A-h>", "<gv", { desc = "Move Selection Left" })
vim.keymap.set("v", "<S-A-l>", ">gv", { desc = "Move Selection Right" })
