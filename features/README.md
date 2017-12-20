# Feature Testing
Feature testing, or Story Testing, is intended to provide verification that particular pieces of the application work in broad terms. They often interact with broad swathes of the application, sometimes even end-to-end from the user interface down into the database.

We follow the page object pattern using [site_prism](https://github.com/natritmeyer/site_prism) instead of pure capybara to ensure that we can separate our test logic from our interaction model. We group our pages into an App object so state is maintained inside of a plain ruby object instead of throughout the tests, which can make tests difficult to parallelize or comprehend when things go wrong.
