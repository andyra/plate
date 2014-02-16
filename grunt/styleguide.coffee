module.exports = kss:
  options:
    framework:
      name: "kss"
    name: "Proto Style Guide"
    template:
      src: "docs/template"
  files:
    "docs":             "assets/stylesheets/source/*.scss"
    "docs/global":      "assets/stylesheets/source/global/*.scss"
    "docs/components":  "assets/stylesheets/source/components/*.scss"
    "docs/base":        "assets/stylesheets/source/base/*.scss"
