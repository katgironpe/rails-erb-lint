# Rails ERB Lint

[![Gem Version](https://badge.fury.io/rb/rails-erb-lint.svg)](http://badge.fury.io/rb/rails-erb-lint)
[![CI Build Status](https://secure.travis-ci.org/katgironpe/rails-erb-lint.svg?branch=master)](http://travis-ci.org/katgironpe/rails-erb-lint)
[![Code Climate](https://codeclimate.com/github/katgironpe/rails-erb-lint.png)](https://codeclimate.com/github/katgironpe/rails-erb-lint)

Checks for the validity of your ERB views.

## "But if you write tests, you won't have these problems"

So test. TDD is not dead.

## Requirements

* Ruby 1.9.3 or greater

## Installation

```bash
gem install rails-erb-lint
```

## Usage

```bash
cd your-rails-app/app/views
rails-erb-lint check
```

By default, we don't show which files are valid as that makes little sense. 
However you can show them through verbose mode.

```bash
cd your-rails-app/app/views
rails-erb-lint check -v
```

## Using Slim and HAML

Initially planned to discontinue the idea of a lint tool for ERB views.
I think there should be a gem that works for Slim/HAML/ERB for that.

ERB by experience is not fun or sensible to use.
HAML or Slim works well.

<a href="https://github.com/slim-template/html2slim" target="_blank">Convert ERB to Slim</a>
