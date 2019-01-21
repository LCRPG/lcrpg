# LCRPG

## Introduction

Welcome to the LCRPG Project. We are trying to build an RPG system where the randomness is in the cards, not in dice.

## Rulebook

You can find the root of the rulebook [here](rules/Intro.md)

We are planning to write our rules in Markdown. See [this](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for a guide.

## Cards

We are planning to use [Squib](https://squib.rocks) for our card creation

## Getting Started

Squib depends on Ruby, and we are using Ruby 2.5.3 which you can get [here](https://www.ruby-lang.org/en/downloads/)
Change to the squib directory and run `gem install bundler`. Then, run `bundler install`.
From there, running `ruby deck.rb` will generate the card files in squib/_output