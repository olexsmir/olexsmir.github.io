local highlighter = {}

--- NOTE: It would be probably better and more idiologic for this project to
--- use nvim's treesitter for parsing, but it's just easier to use chroma
--- https://github.com/alecthomas/chroma

---@param lang string
---@param code string
---@param theme string
local function chroma(lang, code, theme)
  assert(lang ~= "", "Language is not provided")
  assert(code ~= "", "Code is not provided")

  local res = vim
    .system({
      "chroma",
      "--style=" .. theme,
      "--formatter=html",
      "--filename=a." .. lang,
      "--html-only",
    }, { stdin = code, text = true })
    :wait()

  assert(res.code == 0, "Couldn't highlight code using chroma: " .. res.stdout)
  return res.stdout
end

---@param theme string
---@return string
function highlighter.css(theme)
  local res = vim
    .system({
      "chroma",
      "--style=" .. theme,
      "--formatter=html",
      "--html-styles",
    })
    :wait()
  assert(res.code == 0, "Couldn't get css styles using chroma")

  local css = res.stdout or ""
  css = css:gsub("/%*.-%*/ ", "")
  css = css:gsub("\n$", "")
  return css
end

--- Highlight code blocks in HTML string
---@param html string
---@param theme string
---@return string
function highlighter.html(html, theme)
  -- stylua: ignore
  local res = html:gsub('(<pre><code class="language%-([^"]+)">(.-)</code></pre>)', function(_, lang, code)
    return chroma(lang, code, theme)
  end)
  return res
end

return highlighter
