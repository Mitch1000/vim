local ruby_icon_object = {
   icon = "",
   color = "#db507e",
   cterm_color = "168",
   name = "Rb"
}

local git_icon_object = { icon = "", color = "#af5f5f", cterm_color = "160", name = "GitLogo" }
return {
  override_by_extension = {
    ["js"] = { icon = "", color = "#fbfb04", cterm_color = "58",  name = "Js" }
  },
  override_by_filename = {
   [".git-blame-ignore-revs"] = git_icon_object,
   [".gitattributes"] = git_icon_object,
   [".gitignore"] = git_icon_object,
   [".mailmap"] = git_icon_object,
   ["Gemfile"] = ruby_icon_object,
   ["Rakefile"] = ruby_icon_object,
   ["config.ru"] = ruby_icon_object
  },
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
    md = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
    rb = ruby_icon_object,
    git = {
      icon = "",
      color = "#87ffaf",
      cterm_color = "121",
      name = "GitLogo"
    }
  };
}
