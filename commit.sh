#!/usr/bin/env bash
git add $(cd $(dirname $0); pwd)
git commit -m '$1'
git push origin main

