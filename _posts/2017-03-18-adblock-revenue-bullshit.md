---
layout: post
title: Why AdBlock revenue losses estimates are complete bullshit
comments: true
images: true
---

**No one seems to agree on the actual losses due to adblocking.** Instead of informing a critical debate about the future of web advertising, and more broadly, online monetization, I would argue that recent estimates mostly serve the agendas of companies selling adblock mitigation services.

These studies disregard basic statistical analysis principles and come up with **impressive numbers derived from absurd averages**. Since adblocking is a hot topic, I believe they are primarily driven by quick-win PR strategies, because anyone with a basic understanding of online advertising should notice major flaws.

## Flawed methodologies

Take the [following equation](https://www.adback.co/revenue-loss-adblock-websites-ranking#methodology) for yearly losses per site:

```text
(blocked elements) x $0.42 CPM x (country blocking rate) x (page views) x 12
```

The result depends on **too many assumptions**.

**Blocked elements**: Unless you have crawled a [statistically significant sample](https://en.wikipedia.org/wiki/Sample_size_determination) of pages per site to get a _significant_ average of ad slots, per device categories (desktop, tablet, mobile), this number is worthless. Not to mention that ad slots hold very different values, especially display VS video.

> For a skewed data distribution, median is a better measure of center. For any reasonably symmetric distribution with no outliers, mean is a better measure of center. - [Introductory Statistics](https://introductorystats.wordpress.com/2011/09/04/when-bill-gates-walks-into-a-bar/)[^1]

**Average CPM:** CPMs depend on a ton of factors (industry, ad format, ad placement, time of the year, etc.) and most importantly, a simple multiplication doesn't account for [diminishing returns](https://en.wikipedia.org/wiki/Advertising_adstock#Advertising_saturation:_diminishing_returns_effect
): increasing the number of ads on a page doesn't increase your revenue opportunity linearly and, conversely, your losses due to adblock. Using a single rounded global CPM from 2015[^2] is lazy. Would you think for instance that IMDB, the #1 movie site, is selling [custom advertising campaigns](http://www.imdb.com/advertising/) for the average market CPM?

**Country adblocking rate:** PageFair is the global authority when it comes to adblock penetration per country. They even publish [specific rates per category](https://downloads.pagefair.com/downloads/2016/05/2015_report-the_cost_of_ad_blocking.pdf) plus [user demographics](https://pagefair.com/downloads/2017/01/PageFair-2017-Adblock-Report.pdf). Unfortunately, I have yet to see a study using this information as a corrective weighting.

<amp-img
    on="tap:pagefair-verticals"
    role="button"
    tabindex="0"
    layout="responsive"
    alt="Global share of adblocking rates per category"
    src="{{ site.url }}/assets/posts/pagefair-verticals.png" width="800" height="230">
</amp-img>
<amp-image-lightbox id="pagefair-verticals" layout="nodisplay"></amp-image-lightbox>

**Pages views:** You can get traffic data from a number of competitive intelligence tools, but caveats apply. In June 2015, Moz, a leading SEO firm, [benchmarked their accuracy](https://moz.com/rand/traffic-prediction-accuracy-12-metrics-compete-alexa-similarweb/) and was rather disapointed. Considering that even first party analytics and certified metrics must be corrected to account for blockers, traffic estimates should be cross-referenced.

> "**I wouldn’t feel confident using any of these numbers to predict actual traffic**. In particular, I’m baffled by the number of otherwise savvy marketers, investors, and business people who continue to rely on Alexa data." - Rand Fishkin, Moz Co-founder.

## Closing words

**These are not studies but data mashups.** Unless we finally research this issue with proper hypotheses and limited assumptions, the true cost of adblocking will remain unknown. This is a topic with serious implications, that is bound to drive deep changes with [more activity happening server side](https://www.linkedin.com/pulse/my-thoughts-how-internet-industry-circumvent-future-stupid-bourcier) to circumvent both the blockers _and_ privacy directives[^3], which may [lay waste to a distorted ad market](http://digiday.com/podcast/dcn-jason-kint-digiday-podcast/) that’s too reliant on data and intermediaries.

**I am flabbergasted that an industry so hyped on big data and data science has settled for poorly grounded estimates.** An ideal way to look at this issue would rely on revenue per user, per categories. Estimating ARPU is tough, yet this is how analysts work, and there's plenty of pricing data available[^4] for us to come up with finer estimates per categories. Plus, CPM based calculations don't translate in actual RPM losses for publishers. Oh, and when estimating, _it's okay_ to give ranges, rather than questionable grand totals.

**Disclaimer:** I am currently the CTO of [SQweb](https://www.sqweb.com/en), a french company tackling adblock measurement since 2013. We've worked with hundreds of publishers, large and small, with blocking rates ranging from 5% to 37%. Many of them feel completely left out of this conversation because they can't identify with current estimates considering their actual losses.

[^1]: Read ["When Bill Gates walks into a bar"](https://introductorystats.wordpress.com/2011/09/04/when-bill-gates-walks-into-a-bar/) for a great primer on resistant measure.
[^2]: In this particular estimate, the CPM is from "an internal [AppNexus] study published in 2015".
[^3]: Companies [use code to break the law](https://medium.freecodecamp.com/dark-genius-how-programmers-at-uber-volkswagen-and-zenefits-helped-their-employers-break-the-law-b7a7939c6591#.oolvjjoni). Google [was fined $22.5M](https://www.ftc.gov/news-events/press-releases/2012/08/google-will-pay-225-million-settle-ftc-charges-it-misrepresented) for bypassing privacy settings.
[^4]: For a rough idea of CPM distribution per categories, see Salesforce's quarterly [Advertising Index](https://www.salesforce.com/blog/2016/02/salesforce-q3-advertising-index.html).
