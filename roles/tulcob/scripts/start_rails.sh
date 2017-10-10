#! /usr/bin/env bash
cd "{{ app_path }}"
bundle install
rake db:migrate
