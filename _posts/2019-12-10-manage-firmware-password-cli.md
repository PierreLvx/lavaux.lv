---
layout: post
title: Manage your Mac OS firmware password using the command line
comments: true
tags: tips
---

A firmware password prevents starting up from any internal or external storage device other than the startup disk you've selected. It's a great way of protecting your computer from unauthorized tampering and access.

The [official documentation](https://support.apple.com/en-us/HT204455) requires you to boot from the recovery partition to manage the firmware password. However, Mac OS comes with a command line tool that makes it quicker and easier if you are familiar with the terminal.

This tool needs administrative privileges. You must prefix your commands with `sudo` and will be prompted for your user account password.

To configure a firmware password on your machine for the first time, run:

```shell
sudo firmwarepasswd -setpasswd
```

Further commands and details are available in the man page (a very quick read):

```shell
man firmwarepasswd
```
