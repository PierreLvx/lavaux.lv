---
layout: post
title: Setting a lock message on your login window with the terminal (Mac OS)
images: true
comments: true
---

Apple provides [step-by-step instructions](https://support.apple.com/en-us/HT203580) to set a lock message on the login window of your Mac. This spot is very useful to display a company policy or your personal contact details if your laptop is lost.

<amp-img
    on="tap:log-in-screen-custom-message"
    role="button"
    tabindex="0"
    layout="responsive"
    alt="Example custom message on the log in window"
    src="{{ site.url }}/assets/posts/macos-sierra-log-in-screen-custom-message.jpg" width="800" height="465">
</amp-img>
<amp-image-lightbox id="log-in-screen-custom-message" layout="nodisplay"></amp-image-lightbox>

**The lock message can also be configured using the terminal, which is very useful for company wide deployments.** Simply run the command below with whatever text you would like to set (line breaks are supported):

```shell
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This computer is attached to an Apple iCloud account and valuable if lost.\nPlease return by emailing your@email.com."
```
