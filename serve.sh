#!/bin/bash
# Local development server for Jekyll site

echo "Starting Jekyll development server..."
echo "Site will be available at http://127.0.0.1:4000"
echo "Press Ctrl+C to stop"
echo ""

bundle exec jekyll serve --livereload
