---
title: "{{YOUR TITLE}}"
# Pandoc's default templates want plain strings here — structured
# author maps (name/affiliation/email) render as "\author{true}"
author:
  - "{{Author Name}}"
# affiliation and contact go in the author string or a footnote,
# e.g. "Jane Smith^1^" with a footnote, or "Jane Smith (Institution)"
date: "{{Month Year}}"
abstract: |
  {{Your abstract here.}}
keywords:
  - "{{keyword1}}"
  - "{{keyword2}}"
bibliography: ../bibliography/references.bib
csl: ../bibliography/citation-style.csl
link-citations: true
reference-section-title: References
---

# Introduction

{{Begin writing here. Cite sources with `[@authorYear]` syntax (backticks removed once the key exists in the bibliography — an unresolved citation breaks the PDF build).}}

# Background

# Methodology

# Results

# Discussion

# Conclusion
