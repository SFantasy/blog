---
layout: post
date: 2014-08-08 19:00
title: Build personal static wiki site via gollum-site
category: git
keywords: gollum, gollum-site, wiki, GitHub Pages
description: Use gollum to edit wiki contens，then use gollum-site to generate static HTML files，finally push the static files to gh-pages.
comments: true
---

Let's start the article with a few background knowledge:

- **[gollum](https://github.com/gollum/gollum)**: Git-powered wiki engine which provide users a local front-end to edit wiki with various formats (such as GFM, a.k.a, GitHub Flavored Markdown).

- **[gollum-site](https://github.com/dreverri/gollum-site)**: Another Gem written in Ruby. We can consider it a static site generator for gollum. Its function is just like the widely used generator whose name is [Jekyll](jekyllrb.com).

- **[GitHub Pages](https://pages.github.com)**: Official github service for hosting static web sites.

## Purpose

Firstly, I just want to have a personal wiki to manage my knowledge. It should be easy to edit (use Markdown or something like it) the wiki. So I chose **gollum** as the wiki engine and it can fit my requirement perfectly.

Then I want to publish the wiki on the Internet just like my blog and other static sites. This may be easy with the gem named **gollum-site**, 'cause it can generate HTML with the markdown source files.

With the service of GitHub pages, I can easily push contents to the Web.

## Problems


## Best work-flow


--EOF--
