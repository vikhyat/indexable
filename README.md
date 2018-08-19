# Indexable

Drop-in Rack middleware that that executes javascript before serving pages to crawlers.

### Installation

You will need to install PhantomJS. We use the network request abort functionality that was added in version 1.9, so lower versions will not work. You can check the installed version of PhantomJS by running `phantomjs -v`.

#### Rails

Add this to your Gemfile:

    gem 'indexable'

That's it, we're done!

#### Rack

    require 'indexable'
    use Indexable::Middleware

There is an example Rack application in the `example/` directory.

#### Common

**(Optional)** Adding the following meta tag to the head section of your pages will opt you into the [AJAX crawling scheme](https://developers.google.com/webmasters/ajax-crawling/docs/specification), which the middleware uses in addition to checking the user agent in order to determine whether a request is coming from a crawler.

    <meta name="fragment" content="!">

