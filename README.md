# Hubot Reddit Adapter

## Description

This is the [Reddit](http://reddit.com) adapter that allows your hubot to lurk
in your subreddit

## Installation

* Add `hubot-reddit` as a dependency in your hubot's `package.json`
* Install dependencies with `npm install`
* Run hubot with `bin/hubot -a reddit`

### Note if running on Heroku

You will need to change the process type from `app` to `web` in the `Procfile`.

## Usage

You will need to set some environment variables to use this adapter.

### Heroku

    heroku config:add HUBOT_REDDIT_USERNAME="username"
    heroku config:add HUBOT_REDDIT_PASSWORD="password"
    heroku config:add HUBOT_REDDIT_SUBREDDIT="robots"


### Non-Heroku environment variables

    export HUBOT_REDDIT_USERNAME="username"
    export HUBOT_REDDIT_PASSWORD="password"
    export HUBOT_REDDIT_SUBREDDIT="robots"

## Tests

None right now
