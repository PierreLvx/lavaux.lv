---
layout: post
title: Finding your OVH Public Cloud rescue password
comments: true
---

OpenStack lets you rescue an instance, by launching a rescue VM with a temporary root password. You can then mount the filesystem, and perform whatever fixes you have to do, such as replacing a lost SSH key. On OVH however, the password shown in the Manager is invalid.

That's an annoying quirk, but luckily the solution is pretty simple, and you shouldn't need to use the rescue mode too often. I wasted considerable time on this, so here's the solution.

In your OVH dashboard (Cloud Manager), select the server you wish to rescue and in the dropdown, click **Reboot in rescue mode**. A small notice will appear at the bottom right of your screen:

```text
To access your "server-name" server in rescue mode, use :
ssh admin@167.114.246.20 with the temporary password fdKMJyg8g2bvUFyu (this will not be sent to you again).
Warning, only the primary disk will be available in this mode.
```

Don't follow these instructions just yet. Instead, log into [Horizon](https://horizon.cloud.ovh.net)[^1] and make sure you've selected the right region from the top left dropdown (either BHS, GRA, SGB or WAW at the time of this writing).

Now select your instance from the list, and in the **Overview** tab, scroll down to **Meta**. You should see a **rescue_password** entry, which is the right password to use.

If you don't see it here, check the **Log** tab and click **View Full Log**. Scroll down to the bottom of the log file, where you should see something like:

```text
GNU/Linux, to the rescue!

Server:   stock
Login:    root
Password: VE24mdPD2HRG

server-name login: 
```

**Now that you have the right password, go ahead and ssh into the machine, but make sure to ssh as `root` (the default username of OVH's rescue image), contrary to what the Cloud dashboard indicated earlier**.

Once you are done, click **Exit rescue mode** in your dashboard. Voila!

[^1]: If you have never logged into Horizon before, create credentials from your Cloud Manager in the OpenStack tab.