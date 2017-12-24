# How We CSS

## Modularity

We like the thing Brad Frost calls "[atomic design](http://bradfrost.com/blog/post/atomic-web-design/)," which is (confusingly) practically the opposite of the thing a lot of people call "[atomic CSS](https://acss.io/)." We like "atomic design" in the "pattern library" sense for this project because pattern libraries let people who aren't designers build acceptable and maintainable user interfaces quickly.

We've added a "base" directory to Frost's schema for things like colors, typography, shared functions/mixins, and user-agent-stylesheet normalization. The line between "base" and "atoms" is kinda squishy. Let's play it by ear! In general, let's err on the side of moving stuff into "atoms" if we're not sure if it goes in "base" or "atoms."

## SCSS-specific stuff, in lieu of a linter

DO:
* Use variables and mixins a lot.
* Use functions if variables and mixins aren't cutting it.

TRY NOT TO:
* Nest selectors more than a level or so deep -- do you need the specificity? Is there a way to refactor so that you don't?
* Use `@extend` -- please prefer just adding the class in markup, or refactoring to a mixin.
* Use `&` -- again, do you need the specificity, or can you refactor?

PLEASE DON'T:
* Use mixins for auto-prefixing. (We use `autoprefixer` for that.)

## Linting

We don't use `sass-lint` yet, because Betsy hasn't yet figured out how to get `sass-lint` to output specific errors instead of just "there were 3 errors in your SCSS." We would like to use `sass-lint`, but in order to do so we need it to output specific and actionable feedback like `ERROR: nested 5 levels deep on line 39 of /stylesheets/_very_complicated.scss`. We think that it can probably do this and that we are just not using the tool properly. If you have ideas, please help!