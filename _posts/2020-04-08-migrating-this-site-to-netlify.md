---
layout: post
title: Migrating this site from GitHub pages to Netlify
description: Why I have migrated my blog from GitHub pages to Netlify and some of the immediate benefits.
comments: true
---

I started this blog three years ago and hosted it on GitHub pages. Push to deploy was enabled via Travis CI, initially with a little [hackish shell script](https://github.com/PierreLvx/lavaux.lv/commit/4851726eeed61c0c57072a3170122d4e7488f68a). Before HTTPS with custom domains was supported by GitHub, this blog leveraged Cloudflare's free Flexible SSL option.

Today, I am migrating this blog to [Netlify](https://www.netlify.com/), which I have been using on larger projects with great results, including my firm's website. Some of the immediate benefits of this migration are:

- **Fast push to deploy.** This site can compile in seconds with a primed cache. Travis CI sometimes required several minutes before the build started.
- **Custom headers and redirects**. If GitHub Pages is not going to enforce sane defaults such as `X-Content-Type-Options: nosniff`, I should be able to set them myself.
- **Out of the box asset optimization** to minify my HTML, CSS and JavaScript. This site is very light and designed to work with Google Accelerated Mobile Pages, but Netlify does lossless image compression as well.
- **SSL certificate powered by Let's Encrypt**, instead of a Cloudflare SNI certificate with random and sometimes sketchy domains.
- **Deploy previews for pull requests**, which makes it very easy to test changes without breaking the live version.

GitHub provides pages as a convenience to open source community. On the other hand, static hosting is Netlify's core business which makes them more likely to keep investing in the JAMstack and roll out features such as [authentication](https://docs.netlify.com/visitor-access/identity/), [forms](https://docs.netlify.com/forms/setup/) and [serverless](https://docs.netlify.com/functions/overview/) functions.

If you are not familiar with Netlify, do check them out. They have a very generous free tier with 300 build minutes and 100 GB of bandwidth per month, which is plenty for a personal website.
