return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    options = {
      parsers = {
        -- Parses 6-digit or 8-digit hex colors
        hex = { default = true },
        -- Parses rgb(), rgba(), hsl(), and hsla() functions
        css_fn = true,
      },
    },
  },
}
