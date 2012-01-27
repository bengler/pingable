#!/bin/sh

bundle install
bundle exec thin -p 3000 -R config.ru start
