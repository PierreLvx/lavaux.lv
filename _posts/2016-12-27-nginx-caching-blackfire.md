---
layout: post
title: Blackfire profiling and NGINX microcaching
comments: true
tags: tips
---

I am a big fan of [Blackfire](https://blackfire.io/), the PHP profiler from [Sensio Labs](https://sensiolabs.com/en). It is very easy to install and comes with a handy GUI. In the past, tooling such as [XDebug](https://xdebug.org/) + CacheGrind was so tedious that we usually kept profilers for larger projects with critical performance implications.

Recently, I was investigating CPU spikes on a low traffic site, running on a single VM with NGINX microcaching. At least once a week, when multiple crawlers indexed the site aggressively (and hit pages that weren't cached), the CPU went through the roof.

Eventually I got tired of those New Relic alerts. A quick glance at `htop` showed that MySQL was under heavy load. I decided to set up the VM to run a few profiles and share them with the lead developer on that project. Profiles are richer than raw SQL performance metrics or logs. Plus, the culprit could be a poorly written loop. Or a combination of both. With Blackfire, we'd know within minutes.

However, when I launched the test I ran into the following error :

```text
Are you authorized to profile this page?
Probe not found, invalid signature (HTTP 200).
```

I double checked the configuration, and nothing was amiss. The [documentation](https://blackfire.io/docs/reference-guide/configuration#reverse-proxy) covers reverse proxies like Varnish and HA Proxy, but if you're using NGINX with caching the solution is super quick and elegant.

**In your virtual host location block, simply check for Blackfire's header.** Assuming you already have `$no_cache` set up :

```nginx
fastcgi_cache_bypass	$no_cache $http_x_blackfire_query;
fastcgi_no_cache	$no_cache $http_x_blackfire_query;
```

Reload your NGINX configuration, and you should now be able to use the Blackfire Chrome extension as usual.

Bear in mind that any incoming request with a `X-Blackfire-Query` header will completely bypass the cache. If you applied this configuration on a production server, don't forget to revert that change once you are done.

Happy profiling!
