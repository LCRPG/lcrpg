# LCRPG

## Introduction

Welcome to the LCRPG Project. We are trying to build an RPG system where the randomness is in the cards, not in dice.

## Rulebook

You can find the root of the rulebook [here](rules/Intro.md)

We are planning to write our rules in Markdown. See [this](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for a guide.

## Cards

We are planning to use [Squib](https://squib.rocks) for our card creation

## Getting Started

Squib depends on Ruby, and we are using Ruby 2.5.3 (with devkit) which you can get [here](https://www.ruby-lang.org/en/downloads/). When prompted for what components to install, just hit enter.
Change to the squib directory and run `gem install bundler`. Then, run `bundler install`.
From there, running `rake` will generate the card files in squib/_output

## More advanced builds

If you just want one of the component files you can run  
`rake abilities`  
`rake equipment`  
`rake monsters`  
  
if you want to pass it a custom csv to build a smaller pdf, you can run 
`rake abilities["cardfiles/${input.csv}","${output.pdf}]`  
replacing the input and output file names