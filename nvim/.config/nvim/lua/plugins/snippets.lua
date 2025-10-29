-- Advanced snippet management with LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    keys = {
      {
        "<Tab>",
        function()
          local luasnip = require("luasnip")
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            return "<Tab>"
          end
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
        desc = "Expand snippet or jump forward",
      },
      {
        "<S-Tab>",
        function()
          local luasnip = require("luasnip")
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            return "<S-Tab>"
          end
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
        desc = "Jump backward in snippet",
      },
      {
        "<C-l>",
        function()
          local luasnip = require("luasnip")
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Select next choice in snippet",
      },
    },
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Custom snippets for common patterns
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local fmt = require("luasnip.extras.fmt").fmt

      -- TypeScript/JavaScript snippets
      ls.add_snippets("typescript", {
        s("func", fmt("function {}({}) {{\n  {}\n}}", { i(1, "name"), i(2), i(3) })),
        s("afunc", fmt("const {} = async ({}) => {{\n  {}\n}}", { i(1, "name"), i(2), i(3) })),
        s("imp", fmt("import {{{}}} from '{}';", { i(2), i(1) })),
        s("impd", fmt("import {} from '{}';", { i(2), i(1) })),
        s("cl", fmt("console.log({});", { i(1) })),
        s("iife", fmt("(function() {{\n  {}\n}})();", { i(1) })),
      })

      ls.add_snippets("typescriptreact", {
        s(
          "rfc",
          fmt(
            [[
import React from 'react';

interface {}Props {{
  {}
}}

export const {}: React.FC<{}Props> = ({{{}}}) => {{
  return (
    <div>
      {}
    </div>
  );
}};
          ]],
            { i(1, "Component"), i(2), i(1), i(1), i(3), i(4) }
          )
        ),
        s(
          "useState",
          fmt("const [{}, set{}] = useState{}({});", {
            i(1, "state"),
            f(function(args)
              return args[1][1]:gsub("^%l", string.upper)
            end, { 1 }),
            i(2, ""),
            i(3, ""),
          })
        ),
      })

      -- Go snippets
      ls.add_snippets("go", {
        s("err", fmt("if err != nil {{\n  return {}\n}}", { i(1, "err") })),
        s("errp", fmt("if err != nil {{\n  panic(err)\n}}", {})),
        s("errw", fmt('if err != nil {{\n  return fmt.Errorf("{}: %w", err)\n}}', { i(1, "failed to") })),
        s("func", fmt("func {}({}) {} {{\n  {}\n}}", { i(1, "name"), i(2), i(3), i(4) })),
        s(
          "method",
          fmt("func ({} {}) {}({}) {} {{\n  {}\n}}", {
            i(1, "r"),
            i(2, "Receiver"),
            i(3, "Method"),
            i(4),
            i(5),
            i(6),
          })
        ),
        s(
          "test",
          fmt(
            [[
func Test{}(t *testing.T) {{
  {}
}}
          ]],
            { i(1, "Function"), i(2) }
          )
        ),
      })

      -- Python snippets
      ls.add_snippets("python", {
        s("def", fmt("def {}({}):\n    {}", { i(1, "function"), i(2), i(3, "pass") })),
        s(
          "class",
          fmt(
            [[
class {}:
    def __init__(self{}):
        {}
          ]],
            { i(1, "ClassName"), i(2), i(3, "pass") }
          )
        ),
        s(
          "try",
          fmt(
            [[
try:
    {}
except {} as e:
    {}
          ]],
            { i(1), i(2, "Exception"), i(3, "pass") }
          )
        ),
        s("with", fmt("with {} as {}:\n    {}", { i(1), i(2, "f"), i(3) })),
      })

      -- Rust snippets
      ls.add_snippets("rust", {
        s("fn", fmt("fn {}({}) {} {{\n    {}\n}}", { i(1, "name"), i(2), i(3, ""), i(4) })),
        s("impl", fmt("impl {} {{\n    {}\n}}", { i(1, "Type"), i(2) })),
        s(
          "match",
          fmt(
            "match {} {{\n    {} => {},\n    _ => {},\n}}",
            { i(1, "expr"), i(2, "pattern"), i(3, "value"), i(4, "default") }
          )
        ),
        s(
          "test",
          fmt(
            [[
#[test]
fn test_{}() {{
    {}
}}
          ]],
            { i(1, "name"), i(2) }
          )
        ),
      })
    end,
  },
}
