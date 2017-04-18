---
layout: post
title: Caching unsecure static content on an NGINX HTTPS reverse proxy
comments: true
---

A service I manage relies on a third party which still doesn't provide HTTPS. Their endpoint sometimes shows excessive latency as well (>700ms TTFB). Unfortunately, this service isn't trivial to replace (aviation charts), and building our own alternative is out of the question at the moment.

**Let's serve that content securely, while bringing latency down with some simple NGINX chops.**

In our case, I set up a subdomain with a new HTTPS vhost, but you can create a new location block in your existing vhost, especially if you're limited because of your SSL certificate.

If that's the first time you are setting up NGINX caching, you'll need to create a folder for the cache – in our case, I picked `/var/cache/nginx/`.

Then, in your new vhost file, outside of the server block, declare a new zone :

```nginx
proxy_cache_path /var/cache/nginx/yourcache levels=1:2 keys_zone=yourcache:4m inactive=12h;
```

Unless you expect to cache a very large number of static files, [you can keep a pretty small zone](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache_path) :

> All active keys and information about data are stored in a shared memory zone, whose name and size are configured by the `keys_zone parameter. One megabyte zone can store about 8 thousand keys.

Now, the meat and potatoes :

```nginx
location / {
	# The zone
	proxy_cache yourcache;

	# Different caching policies
	proxy_cache_valid 200 302 10m;
	proxy_cache_valid 301 1h;
	proxy_cache_valid 404 1m;

	# We are only downloading image files from this endpoint.
	# We don't want to handle other types of requests.
	proxy_method GET;
	proxy_pass_request_body off;

	# The target endpoint
	proxy_pass http://www.the-endpoint.tld/;

	# Whether the file we requested was in our cache.
	add_header X-Cache-Status $upstream_cache_status;

	# Ignore caching parameters from the origin.
	proxy_ignore_headers Cache-Control;

	# The name of the server processing the request
	proxy_set_header Host $host;

	# Forward the actual end user IP to the origin.
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}
```

If you reload your NGINX configuration, you should be able to securely request resources from the HTTP endpoint through your proxy.

In our case, with cache hits we are seeing an average total response time of 360ms, instead of 680ms. We almost cut it in half! With cache misses, response times are sometimes longer due to the additional latency but this is a minor inconvenience considering our situation.
