---
layout: post
title: How to back up your Gmail/G Suite emails on a Synology NAS
comments: true
tags: tips
---

This weekend I reviewed my email backup strategy and decided to make daily backups of all my accounts directly on my NAS. Since they are all Google-based, I went with `gmvault` on my Synology server. Here's a walkthrough.

There are posts online that achieve this using `ipkg` and compiling dependencies. As of this writing (DSM v6), this is no longer needed.

> **Note:** I'm using the `root` account because I am the only user of that server. Also, this lets me set up a crontab without reloading the cron service between shutdowns and reboots, due to Synology's peculiar cron management system. Keep this in mind if you are on a shared NAS.

Make sure you checked [the Gmail setup](http://gmvault.org/gmail_setup.html) beforehand.

## Initial Setup

1. Log onto DSM, and install Python via the **Package Manager**.

2. Enable SSH in the **Control Panel**, under "Terminal & SNMP".

3. Open a terminal and log in via SSH. You will be prompted for your password.

    ```shell
    ssh pierre@192.168.1.63
    ```

4. Switch to root. Use your password again:

    ```shell
    sudo -i
    ```

5. Download and install the [Python Package Index](https://pypi.python.org/pypi):

    ```shell
    wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
    ```

6. Remove the pip setup script, and install `gmvault`:

    ```shell
    rm get-pip.py && pip install gmvault
    ```

7. Create a folder to store the backups, otherwise they'll go to `$HOME/gmvault-db`:

    ```shell
    mkdir /volume1/gmvault
    ```

8. Run `gmvault`. Notice the `--emails-only` option since I don't care about chats, and `-d` flag with my custom backup path:

   ```shell
   gmvault sync your_account@gmail.com --emails-only -d /volume1/gmvault/your_account\@gmail.com/
   ```

It will run for a while now. Repeat steps 7 and 8 if you have multiple accounts.

## Automated backups with cron

Now, let's set up a cron job to have daily backups.

1. Open the crontab:

    ```shell
    vi /etc/crontab
    ```

2. Edit the crontab. For daily/weekly backups you can use `-t quick`. Note that entries _must_ be delimited by tabs. This will run daily at 2AM :

   ```text
   0 2 * * * root  gmvault sync your_account@gmail.com --resume -t quick --emails-only -d /volume1/gmvault/your_account\@gmail.com/
   ```

3. Save your crontab and restart the cron service:

   ```shell
   synoservice -restart crond
   ```

You're all set!

**Update (May, 25th 2018):** A previous version of this article included a crontab that ran every minute for an hour, instead of once at a given hour. Thanks Kristian for the tip!