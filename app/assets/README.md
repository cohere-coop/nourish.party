# How We Frontend

Philosophical TL;DR: Like [this (content warning: swears)](http://bettermotherfuckingwebsite.com/), but without the heaping helping of contempt culture.

This project has one big frontend goal and one big frontend constraint:

**GOAL**: If someone wants to give a creator who's using nourish.party money, we do not want to get in their way with slow pageloads, buggy Javascript, poor cross-browser support, etc.

**CONSTRAINT**: We do not have a crack frontend infrastructure team, we have a bunch of part-time generalists.

Our front-end decisions should reflect this. When they don't, they should be revised.

## What's This Webpack Thing Anyway?

TL;DR: if you only run `bin/rails s` in local development when you want to work on the frontend, everything will work fine but page refreshes after CSS/JS changes will be slow. If you run `bin/webpack-dev-server` as well as `bin/rails s`, you will get some amount of live updating and page refreshes.

Asset gems don't work; look for equivalent npm packages instead.

## Frameworks

Is `rails-ujs` plus `turbolinks` a framework? Because that's what we're using. That, and as little vanilla JavaScript as is feasible. We might add a [svelte](https://svelte.technology) component or three later if we really need them. We would prefer to design such that we don't need them.

## Cross-Browser Stuff

We care about progressive enhancement. We want all pages to work in all browsers, regardless of age, screen size, Javascript engine and/or blockers, font zoom, accessibility tech, etc. We want all pages to be "not ugly" in most browsers.

We define "working" broadly. "Working" requires two things: 1) all user interactions (approving projects, paying for stuff...) the page is built to support are possible; 2) design elements meant to support understandability and accessibility (like font size differences, form labels, and text contrast) are present.

We define "not ugly" broadly, too. "Not ugly" means that margins and padding are set such that it looks like a designer did things on purpose. "Not ugly" specifically doesn't include pixel-perfection, or design niceties like rounded corners. "Not ugly" can include users of older browsers receiving different layouts than users of newer browsers, as long as those layouts have an understandable/usable content hierarchy and internally consistent spacing. "Not ugly" can also include older browsers seeing an ordinary text field where newer browsers see a datepicker.

When we can deliver design nice-to-haves (to older browsers, or even to newer ones) without adding code complexity, we will try to do so, but this is a resource-constrained project and our design and cross-browser strategy reflects that.
