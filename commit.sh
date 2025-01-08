#!/usr/bin/env bash
cd $(cd $(dirname $0); pwd)
git add .
git commit -m '$1'
git push origin main

