---
layout: post
title: The Linux Kernel Archives is shutting down FTP access, and so should you
comments: true
---

The Linux Kernel Archives [announced last week](https://kernel.org/shutting-down-ftp-services.html) that they were killing their FTP servers, a service "that has important protocol and security implications". If you're managing FTP servers, now is a good time to have a look at your setup too.

**To be blunt, reliance on FTP usually means poor tech ops or that non-technical people are involved in a process that likely needs an overhaul.**

FTP is a [security nightmare](https://www.totemo.com/about/news-events/2015/02/why-ftp-solutions-arent-fit-for-modern-businesses/):

- FTP does not include the ability to encrypt information.
- FTP does not protect usernames and passwords, instead sending them in plain text over the network.
- FTP lacks integrity checking, meaning that neither senders nor recipients have a guarantee that the file reached its intended destination intact.

You should not be deploying code via FTP. If you *really* have to, switch to SFTP and SSH key based authentication. Any decent managed hosting provider will provide SFTP. If you're already versioning your code, with minimal effort you can change to more robust and safer deployment strategies, using [Deploybot](https://deploybot.com/) or [DeployHQ](https://www.deployhq.com/).

If you have people collaborating over FTP, migrate that workflow to Box, Dropbox or Google Drive, which are far better at syncing and managing access rights and provide a superior user experience. I keep hearing about businesses who have their employees use FTP to retrieve files or send deliverables. This sends chills down my spine: FileZilla, the most popular FTP client, doesn't properly encrypt credentials but saves them on disk either in plain text or base64, making them trivial to extract on a compromised workstation.

If you need to sync large quantities of data (thousands of files, and/or several gigabytes), you really should be using `rsync` (for some advanced fine-tuning, see [this gist](https://gist.github.com/KartikTalwar/4393116)) or [Unison](http://www.cis.upenn.edu/~bcpierce/unison/).

Actually, if you're managing large quantities of data, consider using an object storage such as AWS S3 ([s3cmd](http://s3tools.org/s3cmd)) or Google Cloud Storage ([gsutil](https://cloud.google.com/storage/docs/gsutil)) rather than an FTP server. See for yourself, and you may find that using cold storage and lifecycle rules, you can save on your bill plus enjoy modern, flexible tooling. GUIs are even available for S3, such as [Cyberduck](https://cyberduck.io/).

**FTP is an unsecure, obsolete protocol that doesn't spur best practices. As such, you should ban it from your environment and remove it from your servers.**
