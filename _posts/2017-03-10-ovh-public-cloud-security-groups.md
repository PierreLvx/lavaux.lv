---
layout: post
title: Beware of the default Security Group on OVH Public Cloud
comments: true
tags: tips
---

OVH has a public cloud offering, based on OpenStack, with an excellent price-performance ratio. With data centers in Europe and Canada, they are a great choice for standard compute, networking and storage needs. But there's a catch: **you absolutely must tighten security up**.

Other public cloud providers provide sane defaults. [Google Cloud](https://cloud.google.com/compute/docs/networking#firewall_rules), [Microsoft Azure](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-nsg), and [AWS](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html) have a **deny all by default** policy regarding inbound traffic.

And so does [OpenStack](https://docs.openstack.org/admin-guide/cli-nova-manage-projects-security.html):

> All projects have a `default` security group which is applied to any instance that has no other defined security group. Unless you change the default, **this security group denies all incoming traffic** and allows only outgoing traffic to your instance.

Even Lightsail, Amazon's easy to use Virtual Private Servers, come with [default rules](https://lightsail.aws.amazon.com/ls/docs/overview/article/understanding-firewall-and-port-mappings-in-amazon-lightsail) only allowing SSH and web traffic.

## The issue

OVH [decided otherwise](https://www.ovh.com/fr/g1925.configurer_un_groupe_de_securite)[^1]. **New cloud projects allow all incoming traffic**.

**This is reckless**.

At the time of this writing, the web interface shows zero warning, and the firewall tab is unavailable. Yet, this is the interface most people new to the platform, including beginners and hobbyists with limited system administration acumen, will use to spin up new instances, unknowingly leaving them wide open.

## How to fix this?

You can use the `openstack security group` command line, and if you feel comfortable doing so you probably don't need my help.

Let's see how to use the online Horizon interface instead.

If this is your first time accessing Horizon, follow [this guide](https://www.ovh.com/us/g1773.configure_user_access_to_horizon). Once connected, you should see your Project ID in the top menu bar, followed by a region identifier (such as "BHS1"). If your instances are running in another region, carry on anyway since you have to fix them all. Then:

1. In the "Compute" menu on the left, select "Access & Security".
2. In the "Security Groups" tab, you should see the `default` group. Click "Manage Rules".
3. Add new rules as required. In the case of a web server, most likely you'll want SSH, HTTP, and HTTPS only.
4. Delete ingress rules that allowed all inbound traffic from CIDR remotes (you should see IP v4 and v6 notation). Unless you have a specific security posture, you can keep the rules with a “default” remote – these are for private networking within your project.
5. Rinse and repeat in all regions (BHS1, GRA1, SBG1) and cloud projects.

## How bad is it?

Recent [ransom attacks](https://www.bleepingcomputer.com/news/security/database-ransom-attacks-have-now-hit-mysql-servers/) on all kinds of databases have reiterated the critical importance of sane security defaults. With over [100.000 instances in production](http://www.journaldunet.com/solutions/cloud-computing/1186311-le-cloud-ovh-enregistre-100-000-vm-en-production/) (article in French), OVH should no longer make convenience-based security choices. I manage around 30 instances on this cloud, and I can tell you firsthand there is active scanning going on.

~~DigitalOcean, another popular provider due to their ease of use and pricing, does allow all inbound traffic by default. However, like most VPS providers, security groups simply don't exist on their platform. Hundreds of their customers [have shown interest](https://digitalocean.uservoice.com/forums/136585-digitalocean/suggestions/2624488-cloud-firewall) in a user-friendly firewall solution, but in the meantime, their community provides a number of detailed [step by step guides](https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers#firewalls).~~ (Update since original publication: Digital Ocean introduced [Cloud Firewalls](https://www.digitalocean.com/docs/networking/firewalls/) in June 2018)

**Since OVH decided to weaken an OpenStack default, their documentation should include a clear warning, but neither the [French](https://www.ovh.com/fr/g2018.debuter_avec_une_instance_public_cloud) or [English](https://www.ovh.co.uk/g1775.create_an_instance_in_your_ovh_customer_account) versions do. The web interface should also be explicit about this policy when creating new projects.** People _will_ get compromised with the default policy.

[^1]: Sorry, I couldn't find this page in English.
