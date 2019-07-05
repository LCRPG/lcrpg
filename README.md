# LCRPG
[![Build Status](https://dev.azure.com/rpcg/rpcg/_apis/build/status/RPCG.rpcg?branchName=master)](https://dev.azure.com/rpcg/rpcg/_build/latest?definitionId=1&branchName=master)

## Introduction

Welcome to the LCRPG Project. We are trying to build an RPG system where the randomness is in the cards, not in dice.

## Rulebook

You can find the root of the rulebook [here](rules/Intro.md).

We are writing our rules in Markdown. See [this](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for a guide.

## Cards

We use [Squib](https://squib.rocks) to generate cards from our sheets. More to follow on this.

## Getting Started

Squib depends on Ruby, and we are using Ruby 2.5.3 (with devkit) which you can get [here](https://www.ruby-lang.org/en/downloads/). When prompted for what components to install, just hit enter.
Change to the squib directory and run `gem install bundler`. Then, run `bundler install`.
From there, running `rake` will generate the card files in squib/_output.

## More advanced builds

If you just want one of the component files you can run  
`rake abilities`  
`rake equipment`  
`rake monsters`  
  
if you want to pass it a custom csv to build a smaller pdf, you can run 
`rake abilities["cardfiles/${input.csv}","${output.pdf}]`  
replacing the input and output file names.

## Standard tooling

We recommend using [Visual Studio Code](https://code.visualstudio.com/download) with all recommended extensions to develop for RPCG, as it'll ensure we keep consistent formatting etc. 

## Azure Pipelines and PR Review

We use Azure Pipelines to provide a way to generate sample built print sheets to each Pull Request. You can view the build status by clicking on the Build Status badge at the top of this page. If you want to view the print sheets for a given build, navigate to the Build Summary tab and either download the `printsheets` artifact, or click the context menu to explore the artifact without downloading the entire ZIP folder.