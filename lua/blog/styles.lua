return {
  [":root"] = {
    ["--width"] = "720px",
    ["--font-main"] = "Verdana, sans-serif",
    ["--font-secondary"] = "Verdana, sans-serif",
    ["--font-scale"] = "1em",
    ["--background-color"] = "#1a1b26",
    ["--heading-color"] = "#a9b1d6",
    ["--text-color"] = "#c0caf5",
    ["--link-color"] = "#7dcfff",
    ["--visited-color"] = " #1abc9c",
    ["--code-background-color"] = "#414868",
    ["--code-color"] = "#7aa2f7",
    ["--blockquote-color"] = "#ccc",
  },

  ["@media (prefers-color-scheme: light)"] = {
    [":root"] = {
      ["--background-color"] = "#fff",
      ["--heading-color"] = "#222",
      ["--text-color"] = "#444",
      ["--link-color"] = "#3273dc",
      ["--visited-color"] = " #8b6fcb",
      ["--code-background-color"] = "#f2f2f2",
      ["--code-color"] = "#222",
      ["--blockquote-color"] = "#222",
    },
  },

  body = {
    ["font-family"] = "var(--font-secondary)",
    ["font-size"] = "var(--font-scale)",
    margin = "auto",
    padding = "20px",
    ["max-width"] = "var(--width)",
    ["text-align"] = "left",
    ["background-color"] = "var(--background-color)",
    ["word-wrap"] = "break-word",
    ["overflow-wrap"] = "break-word",
    ["line-height"] = "1.5",
    color = "var(--text-color)",
  },

  ["h1, h2, h3, h4, h5, h6"] = {
    ["font-family"] = "var(--font-main)",
    color = "var(--heading-color)",
  },

  a = {
    color = "var(--link-color)",
    cursor = "pointer",
    ["text-decoration"] = "none",

    [":hover"] = { ["text-decoration"] = "underline" },
  },

  main = { ["line-height"] = "1.6" },
  table = { ["width"] = "100%" },
  img = { ["max-width"] = "100%" },
  ["nav a"] = { ["margin-right"] = "8px" },
  ["strong, b"] = { color = "var(--heading-color)" },
  [".inline"] = { width = "auto !important" },

  button = {
    margin = "0",
    cursor = "pointer",
  },

  time = {
    ["font-family"] = "monospace",
    ["font-style"] = "normal",
    ["font-size"] = "15px",
  },

  hr = {
    border = "0",
    ["border-top"] = "1px dashed",
  },

  code = {
    ["font-family"] = "monospace",
    padding = "2px",
    ["background-color"] = "var(--code-background-color)",
    color = "var(--code-color)",
    ["border-radius"] = "3px",
  },

  blockquote = {
    color = "var(--code-color)",
    ["border-left"] = "1px solid #999",
    ["padding-left"] = "20px",
    ["font-style"] = "italic",
  },

  footer = {
    padding = "25px 0",
    ["text-align"] = "center",
  },

  [".title"] = {
    [":hover"] = { ["text-decoration"] = "none" },
    h1 = { ["font-size"] = "1.5em" },
  },

  [".highlight, .code"] = {
    padding = "1px 15px",
    color = "var(--code-color)",
    ["background-color"] = "var(--code-background-color)",
    ["border-radius"] = "3px",
    ["margin-block-start"] = "1em",
    ["margin-block-end"] = "1em",
    ["overflow-x"] = "auto",
  },

  ul = {
    ["&.blog-posts"] = {
      ["list-style-type"] = "none",
      padding = "unset",
    },
    ["&.blog-posts li"] = { display = "flex" },
    ["&.blog-posts li span"] = { flex = "0 0 130px" },
    ["&.blog-posts li a:visited "] = { color = "var(--visited-color)" },
  },
}
