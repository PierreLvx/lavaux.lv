---
layout: post
title: A few tips to use private NodeJS repositories with the GitHub Packages Registry
comments: true
tags: tips
---

Lately, I have been building some internal tools to speed up to day-to-day operations at [SGH Capital](https://www.sghcapital.com/).

These tools share several JavaScript dependencies and a common library of UI components, so it seemed like a good opportunity to build an internal `npm` package which we can then require in multiple projects.

Having never used the GitHub Packages Registry, I had to do some Googling to get it all working. This post is not a step-by-step tutorial but some quick tips to supplement the official docs, which may be useful if you are doing this for yourself.

## Tip #1: Private GitHub repositories will be Private GitHub Packages

Unless you are publishing open-source code, it's very likely that your code is hosted in a private repo and that your `package.json` includes the following line:

```js
  "private": true
```

However, when you try to publish it to the GitHub Packages Registry, you should get the following error:

```
npm ERR! code EPRIVATE
npm ERR! This package has been marked as private
npm ERR! Remove the 'private' field from the package.json to publish it.
```

I did not find any mention of this in GitHub's documentation, but **when publishing a package from a private GitHub repo, the resulting GitHub package will automatically be private**. I simply removed the private field as instructed and my package was indeed published as a private.

## Tip #2: Your package name should be all lowercase

GitHub Packages names must begin with your GitHub username, so I expected the package name to be case sensitive.

It turns out that `npm` requires lowercase package names because Windows systems are not case-sensitive by default.

## Tip #3: Simple token authentication to use your private package on Heroku

Some of our tools are currently deployed on Heroku, so we need Heroku to authenticate against the GitHub Registry to fetch our private packages.

`npm` can perform this authentication interactively with the `npm login` command, or with an `authToken` in the `.npmrc` file. The auth token must be a GitHub token with the right scopes enabled (at least `read:packages` and `repo` in my experience).

While you can certainly generate your `.npmrc` with a custom script that will be executed during the `heroku-prebuild` hook as suggested [here](https://dev.to/johan_du_toit/heroku-github-private-packages-2d0a), a much simpler way is to store your GitHub Access Token as an environment variable and to update your `.npmrc` with the following one-liner:

```js
  "heroku-prebuild": "echo //npm.pkg.github.com/:_authToken=$GITHUB_TOKEN >> .npmrc",
```

Now, when building your slug, Heroku will be able to download your private packages from the GitHub Registry.

Happy packaging!
