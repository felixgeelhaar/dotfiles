return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require 'which-key'
      wk.setup {
        preset = 'modern',
        spec = {
          { '<leader>c', group = 'code' },
          { '<leader>d', group = 'debug' },
          { '<leader>f', group = 'file' },
          { '<leader>g', group = 'git' },
          { '<leader>q', group = 'quit' },
          { '<leader>x', group = 'quickfix' },
          { '<leader>o', group = 'overseer' },
        },
        win = {
          title = false,
        },
        icons = {
          rules = false,
        },
      }
    end,
  },
}

-- {
--   'folke/which-key.nvim',
--   event = 'VimEnter', -- Sets the loading event to 'VimEnter'
--   config = function() -- This is the function that runs, AFTER loading
--     require('which-key').setup()
--
--     -- Document existing key chains
--     require('which-key').register {
--       ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--       ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--       ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--       ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--       ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--       ['<leader>t'] = { name = '[T]rouble', _ = 'which_key_ignore' },
--     }
--   end,
