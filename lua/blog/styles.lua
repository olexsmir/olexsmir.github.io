return {
  [":root"] = {
    ["--width"] = "720px",
    ["--font-main"] = "sans-serif",
    ["--font-scale"] = "1em",
    ["--background-color"] = "#1a1b26",
    ["--heading-color"] = "#a9b1d6",
    ["--text-color"] = "#c0caf5",
    ["--link-color"] = "#7dcfff",
    ["--visited-color"] = "#3273dc",
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
    font_family = "var(--font-secondary)",
    font_size = "var(--font-scale)",
    margin = "auto",
    padding = "20px",
    max_width = "var(--width)",
    text_align = "left",
    background_color = "var(--background-color)",
    word_wrap = "break-word",
    overflow_wrap = "break-word",
    line_height = "1.5",
    color = "var(--text-color)",
  },

  main = { line_height = "1.6" },

  ["h1, h2, h3, h4, h5, h6"] = {
    font_family = "var(--font-main)",
    color = "var(--heading-color)",
  },

  header = { padding_bottom = "0.3rem" },

  footer = {
    padding = "25px 0",
    text_align = "center",
  },

  ["nav a"] = { margin_right = "8px" },
  ["nav p"] = { margin_bottom = "0px" },

  a = {
    color = "var(--link-color)",
    cursor = "pointer",
    text_decoration = "none",

    ["&:hover"] = { text_decoration = "underline" },
  },

  table = { width = "100%" },
  img = { max_width = "100%" },
  ["strong, b"] = { color = "var(--heading-color)" },

  button = {
    margin = "0",
    cursor = "pointer",
  },

  time = {
    font_family = "monospace",
    font_style = "italic",
    font_size = "15px",
  },

  hr = {
    border = "0",
    border_top = "1px dashed",
  },

  pre = {
    background_color = "var(--code-background-color)",
    padding = "10px",
    border_radius = "3px",
    overflow_x = "auto",

    code = {
      background_color = "transparent",
      padding = "0",
      border_radius = "0",
    },
  },

  code = {
    font_family = "monospace",
    background_color = "transparent",
  },

  blockquote = {
    color = "var(--code-color)",
    border_left = "1px solid #999",
    padding_left = "20px",
    font_style = "italic",
  },

  i = {
    font_style = "italic",
  },

  [".title"] = {
    h1 = {
      font_size = "1.5em",
      margin_top = "0px",

      ["&:hover"] = {
        text_decoration = "none",
      },
    },
  },

  [".inline"] = { width = "auto !important" },

  ul = {
    ["&.blog-posts"] = {
      list_style_type = "none",
      padding = "unset",
    },
    ["&.blog-posts li"] = { display = "flex" },
    ["&.blog-posts li span"] = { flex = "0 0 130px" },
    ["&.blog-posts li a:visited "] = { color = "var(--visited-color)" },
  },

  [".blog-title"] = {
    h1 = {
      margin_top = "0px",
      margin_bottom = "0px",
    },
    p = { margin_top = "0px" },
  },
}
