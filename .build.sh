#!/bin/bash

# Only proceed script when started not by Pull Request.
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "This is PR, exiting."
  exit 0
fi

# Enable error reporting to the console.
set -e

# Build site with jekyll, by default to `_site' folder.
bundle exec jekyll build

# Clone 'gh-pages' branch of the repository using encrypted GH_TOKEN for authentification.
git clone -b gh-pages https://${GH_TOKEN}@github.com/PierreLvx/lavaux.lv.git ../lavaux.lv.git.gh-pages

# Copy generated HTML site to 'gh-pages' branch.
cp -R _site/* ../lavaux.lv.git.gh-pages

# Commit and push generated content to 'gh-pages' branch.
# Since repository was cloned in write mode with token auth - we can push there.
cd ../PierreLvx/lavaux.lv.git.gh-pages
git config user.email "pierre@lavaux.lv"
git config user.name "Pierre Lavaux"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
# Hiding all the output from git push command, to prevent token leak.
git push --quiet origin gh-pages > /dev/null 2>&1
