#!/bin/bash

cd /tr && gulp db:restore && gulp build --no-tests --no-docs
