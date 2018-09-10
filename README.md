# Resuby

[![Gem](https://img.shields.io/gem/v/resuby.svg?style=flat-square)](https://rubygems.org/gems/resuby)
[![GitHub issues](https://img.shields.io/github/issues/mardotio/resuby.svg?style=flat-square)](https://github.com/mardotio/resuby/issues)
[![Gem](https://img.shields.io/gem/dtv/resuby.svg?style=flat-square)](https://rubygems.org/gems/resuby)

## Overview

Resuby is a gem that takes a `YAML` or `JSON` configuration file that contains all of your resume information, and turns
it into a resume you can actually use to find your next job. The data file is converted into an HTML file, and the
accompanying CSS styles, which you can then view in a browser. From there, you can print your resume, save it as a PDF,
or do anything else you can do to a web page.

This project was inpired by my need to get away from awkward tables in Word, and my desire to be able to version control
my resume. With Resuby, you only need to store the `JSON`, or `YAML` file, as the HTML and CSS can easily be generated
again (although you could certainly save that too).

## Table of Contents

<!-- TOC -->

- [Resuby](#resuby)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
    - [CLI](#cli)
      - [Generating Resume](#generating-resume)
  - [Compatibility](#compatibility)

<!-- /TOC -->

## Installation

To install, simply run `gem install resuby`.

In addition to resuby, it will install SASS, which is a common CSS pre-compiler that is used by resuby to generate the
CSS file for your resume, and Optimist, which is used to handle CLI interactions.

## Usage

### CLI

By default, the `resuby` executable will look for a file called `resume.yaml` in your current working directory (you can
pass it a different path). The `YAML` or `JSON` file needs to contain all of the information you want in your resume.
The table below summarizes the keys that `resuby` expects to find in the data file.

|Key|Class|Required|Description|
|---|-----|--------|-----------|
|`name`|String|*|Your name|
|`contact`|Array|*|Any contact information (i.e. phone, email)|
|`profile`|String||A small paragraph that describes you|
|Any other key|Array||These will become the headers for your other resume sections (i.e. `education` -> `Education`, `projects_&_experience` -> `Projects & Experience`|

Each array element under the headers you create is expected to be a hash. All of the array elements under those sections
will become a new row under that header. Below are the expected key values for each array element.

|Key|Class|Required|Description|
|---|-----|--------|-----------|
|`desc`|String|*|Description for that section (i.e. dates), will be displayed to the left of that section|
|`title`|String||Main point for that row, will have slightly larger font than the rest of the values|
|`subtitle`|String||Will be displayed right under the title, will be in italics|
|`data`|Array|*|Any other info, such as accomplishments,  each array element will be a new bullet|

[`default.yaml`](/examples/default.yaml) contains a sample `YAML` structure. [`default.json`](/examples/default.json)
contains a sample `JSON` structure.

#### Generating Resume

Once you have a data file, you can run the following command from the same directoy:

```
resuby generate
```

Running this command will generate a file called `resume.html`, and a `css/` directory in your current workspace. Now
you can simply open this in a browser, and print it (__make sure that the printed page has no margins, as the HTML
generated will have its own margins set__).

You can run `resuby generate --help` to get additional information about the executable.


## Compatibility

The generated HTML and styling has only been tested in Chrome and Safari. This doesn't mean it won't work on other
browsers, but it is not guaranteed to look as designed.
