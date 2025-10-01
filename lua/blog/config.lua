local config = {}

config.name = "olexsmir"
config.title = "olexsmir's blog"
config.email = "olexsmir@cock.li"
config.url = "https://olexsmir.github.io"
config.feed = {
  subtitle = "olexsmir's blog feed",
  url = config.url .. "/feed.xml",
}

config.build = {
  output = "build",
  assets = "assets",
  posts = "posts",
}

return config
