#import "@preview/catppuccin:1.1.0": flavors, set-code-theme

#set document(
  title: "Git and GitHub",
)

#set page(
  paper: "a4",
  background: image(
    "assets/core_logo.opacity.png",
    width: 100%,
    height: 100%,
  ),
)

#set heading(numbering: "1.1.")

#set figure.caption(position: bottom)
#set figure(supplement: [Figure])

#let palette = flavors.mocha.colors

#show raw.where(block: true): it => block(
  fill: palette.base.rgb,
  inset: 10pt,
  radius: 4pt,
  stroke: palette.surface0.rgb,
  text(fill: palette.text.rgb, it),
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x:3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
#show raw.where(block: true): block_it => {
  show raw.line: line_it => {
    box(width: 2em, text(fill: gray, if block_it.lang == "sh" [\$] else [#line_it.number]))
    line_it.body
  }
  block_it
}

#show link: set text(blue)

#align(center)[#title()]

#include "vcs.typ"
#include "git.typ"
