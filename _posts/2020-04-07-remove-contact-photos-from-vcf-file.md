---
layout: post
title: Batch remove photos from VCF files and Apple Contacts
description: How to use a python script to remove contact photos and other fields from VCF files.
comments: true
---

Over the years, I have tried many services to enrich my address book and to keep my contacts up to date. Yet, none of the solutions were doing well enough for me to leave them on autopilot.

Eventually, I went back to maintaining my address book manually because it was much cleaner. However, doing so with Mac OS native Contacts app was painful: search would take several seconds and it would freeze on a regular basis, which is a ridiculous problem to have on any computer with decent specs.

With close to 1.900 contacts, including a lot of information that was added over the years by contact enrichment apps, my address book was bloated. I assumed hundreds of profile photos were not helping, and I had no use for them anyway.

The Contacts app does not offer a way to batch remove fields, so I turned to the [vCard format](https://en.wikipedia.org/wiki/VCard), which is open and easy to parse. Profile photos are included in base64 format so I figured, I could process a VCF export to strip that field.

Thankfully, a quick GitHub search turned up [a python script](https://github.com/emeidi/strip-images-from-apple-vcard) written by [Mario Aeby](https://twitter.com/MarioAeby) which worked perfectly.

It was also very easy to add extra fields to remove. Simply copy the following block and change the field name (e.g.  `TITLE` if you want to strip out job titles):

```python
if re.match('PHOTO',line):
	debugMsg("Found line starting with PHOTO. Skipping.")
	continue
```

**After removing all the profile pictures, my VCF export weighted 936 KB instead of 61 MB.** I then erased my contacts database and imported the slimmed-down backup. Performance of Mac OS Contacts app is now acceptable, even though I am convinced it simply struggles with larger address books.

My fork of Mario's script with very minor edits is [available on GitHub](https://github.com/PierreLvx/strip-images-from-apple-vcard).