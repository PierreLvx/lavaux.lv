---
layout: post
title: Configure msmtp to use Mailgun or Sendgrid
comments: true
---

I had a few VMs configured with [ssmtp](https://github.com/badoo/ssmtp/commits/master) to relay a small number of emails, usually from cron jobs. Unfortunately, this project is no longer maintained so it's unfit for production, and while Postfix is a solid piece of software, I was looking for something very lightweigth.

I came across [msmtp](https://marlam.de/msmtp/), which fit the bill perfectly and is trivial to set up.

On a Debian based distro :

```shell
apt install msmtp msmtp-mta
```

Then create `/etc/msmtprc` to configure it globally on your host. You'll need to edit the values in caps with [your SMTP credentials](https://help.mailgun.com/hc/en-us/articles/203409084-How-do-I-create-additional-SMTP-credentials-) :

```text
defaults
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile /var/log/msmtp.log

account mailgun
host smtp.mailgun.org
port 587
auth on
user YOUR@MAILGUN_USER.TLD
password YOUR_PASSWORD
from FROM@YOURDOMAIN.TLD

account default : mailgun
```

You should definitely keep logging enabled. There's [a wealth of information](https://marlam.de/msmtp/msmtp.html#Logging) that will come handy.

Using a service like Mailgun, rather than your own SMTP server, ensures better delivery of your email, along with detailed logs and sending stats. If these emails are somewhat critical to you, you may want to set up a secondary provider such a [Sendgrid](https://sendgrid.com/) so that you can failover easily, albeit manually – if you need this to be automated because they are mission critical, that's a job for Postfix.

Simply create another `account` section. Instead of SMTP credentials, you'll have to [create an API key](https://sendgrid.com/docs/Classroom/Send/How_Emails_Are_Sent/api_keys.html) with sending permissions. Again, edit accordingly :

```text
account sendgrid
host smtp.sendgrid.net
port 587
auth on
user apikey
password YOUR_API_KEY
from FROM@YOURDOMAIN.TLD
```

Note that `user` *should* be `apikey`.

If you need specific user configurations, you can create `~/.msmtprc` files. To route emails to different recipients, you can [set up aliases](https://marlam.de/msmtp/msmtp.html#Aliases-file).

Also, you can [customize the timeout](https://marlam.de/msmtp/msmtp.html#General-commands) per account using e.g. `timeout 60` to wait one minute.

Finally, send a test email from the command line :

```shell
echo "Subject: Testing msmtp" | sendmail -v your@email.tld
```

If everything went well, you should see your test within a few seconds.

**Update Sept. 8th 2019:**

- `msmtp` links updated to current project homepage.
