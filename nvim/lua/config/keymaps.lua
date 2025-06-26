-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("v", "<leader>ay", function()
  vim.cmd('normal! "zy')
  local selected_text = vim.fn.getreg("z")

  if not selected_text or selected_text == "" then
    vim.notify("No text selected", vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", selected_text)
  vim.notify("Copied to clipboard, opening Raycast AI...")

  local raycast_url = "raycast://extensions/raycast/raycast-ai/ai-chat"
  vim.fn.system("open '" .. raycast_url .. "'")
end, { desc = "Raycast (Prompt)" })

vim.keymap.set("v", "<leader>ar", function()
  vim.cmd('normal! "zy')
  local selected_text = vim.fn.getreg("z")

  if not selected_text or selected_text == "" then
    vim.notify("No text selected", vim.log.levels.WARN)
    return
  end

  -- Copy selected text to system clipboard
  vim.fn.setreg("+", selected_text)

  -- URL encode function
  local function url_encode(str)
    if not str then
      return ""
    end
    str = string.gsub(str, "([^%w%-%.%_%~])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
    return str
  end

  -- Function to submit the prompt
  local function submit_prompt(prompt_text, buf, win)
    if not prompt_text or prompt_text == "" then
      vim.notify("No prompt entered", vim.log.levels.WARN)
      return
    end

    -- Create JSON arguments object with just the Task
    local encoded_args = url_encode(prompt_text)

    vim.notify("Submitting prompt: " .. prompt_text)

    local raycast_url = "raycast://ai-commands/selected-text?arguments=" .. prompt_text
    vim.fn.system("open '" .. raycast_url .. "'")

    -- Close the floating window
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  -- Create floating window for prompt input
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.min(80, vim.o.columns - 4)
  local height = 10
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Enter your prompt (Ctrl+Enter to submit, Esc to cancel) ",
    title_pos = "center",
  })

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Create preview text, removing newlines and limiting length
  local preview = selected_text:gsub("[\n\r]", " "):sub(1, 100)
  if string.len(selected_text) > 100 then
    preview = preview .. "..."
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "# Enter your AI prompt below:",
    "# Text copied to clipboard: " .. preview,
    "",
    "",
  })

  -- Position cursor on the fourth line
  vim.api.nvim_win_set_cursor(win, { 4, 0 })

  -- Set up keymaps for the floating window
  local opts = { buffer = buf, silent = true }

  -- Ctrl+Enter to submit
  vim.keymap.set({ "n", "i" }, "<C-CR>", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 3, -1, false)
    local prompt_text = table.concat(lines, "\n"):gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
    submit_prompt(prompt_text, buf, win)
  end, opts)

  -- Alternative: Ctrl+S to submit (in case Ctrl+Enter doesn't work in your terminal)
  vim.keymap.set({ "n", "i" }, "<C-s>", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 3, -1, false)
    local prompt_text = table.concat(lines, "\n"):gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
    submit_prompt(prompt_text, buf, win)
  end, opts)

  -- Escape to cancel
  vim.keymap.set({ "n", "i" }, "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end, opts)

  -- Start in insert mode
  vim.cmd("startinsert")
end, { silent = true, desc = "Raycast (Send)" })

vim.keymap.set("n", "<leader>yf", "<cmd>:%y+<cr>", { silent = true, desc = "Yank Entire File" })
vim.keymap.set("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit" })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "+", "<cmd>wincmd =<cr>", { silent = true })
vim.keymap.set("n", "=", "<cmd>vertical resize +10<cr>", { silent = true })
vim.keymap.set("n", "-", "<cmd>vertical resize -10<cr>", { silent = true })

vim.keymap.set("n", ",tw", "<cmd>set invwrap<CR><cmd>set wrap?<CR><cmd>set linebreak<CR>", { silent = true })
vim.keymap.set("n", ",,a", "ggVG", { desc = "Select entire file" })
vim.keymap.del("v", "<")
vim.keymap.del("v", ">")

vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>", { silent = true })
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>", { silent = true })
