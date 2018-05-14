# Resuby

[![Gem](https://img.shields.io/gem/v/resuby.svg?style=flat-square)](https://rubygems.org/gems/resuby)
[![GitHub issues](https://img.shields.io/github/issues/mardotio/resuby.svg?style=flat-square)](https://github.com/mardotio/resuby/issues)
[![Gem](https://img.shields.io/gem/dtv/resuby.svg?style=flat-square)](https://rubygems.org/gems/resuby)

## Overview

Resuby is a gem that takes a `yaml` configuration file that contains all of your
resume information, and turns it into a resume you can actually use to find your
next job. After you generate your resume, you will have an HTML file that you
can open in your favorite browser (as long as yor favorite browser is Chrome or
Safari), and view the end result.

## Table of Contents

<!-- TOC -->

- [Resuby](#resuby)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Generating Resume](#generating-resume)
  - [Compatibility](#compatibility)

<!-- /TOC -->

## Installation

To install, simply run `gem install resuby`.

In addition to resuby, it will install SASS, which is a common CSS pre-compiler
that is used by resuby to generate the CSS file for your resume.

## Usage

In order for the script to work, you will first need to create a file in the
root directory of the project called `resume.yaml`. This file should contain
your name, contact information, and any other information that you want in your
resume. Below are the keywords that are expected in the yaml file.

|Key|Class|Required|Description|
|---|-----|--------|-----------|
|`name`|String|True|Your name|
|`contact`|Array|True|Any contact information (i.e. phone, email)|
|`profile`|String|False|A small paragraph that describes you|
|Any other key|Array|False|These will become the headers for your other resume sections (i.e. education -> Education, projects_&_experience -> Projects & Experience|

Each array element under the headers you create is expected to be a hash. All of
the array elements under those sections will become a new row under that header.
Below are the expected key values for each array element under your headers.

|Key|Class|Required|Description|
|---|-----|--------|-----------|
|`title`|String|False|Main point for that row, will have slightly larger font than the rest of the values|
|`desc`|String|True|Description for that section (i.e. dates), will be displayed to the left of that section|
|`subtitle`|String|False|Will be displayed right under the title, will be in italics|
|`data`|Array|True|Any other info, such as accomplishments,  each array element will be a new bullet|

[`default.yaml`](/examples/default.yaml) contains a sample structure.

## Generating Resume

Once you have created a `resume.yaml` file, you can run the following command
from the same directoy:

```
resuby generate
```

Running this command will generate a file called `resume.html` in your current
directory. Now you can simply open this in a browser, and print it (__make sure
that the printed page has no margins, as the HTML generated will have its
own margins set__).


## Compatibility

The generated HTML and styling has only been tested in Chrome and Safari.
This doesn't mean it won't work on other browsers, but it is not guaranteed to
look as designed.
