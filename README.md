# Indexable

Drop-in Rack middleware that that executes javascript before serving pages to crawlers.

### Installation

You will need to install PhantomJS. We use the network requst abort functionality that was added in version 1.9, so lower versions will not work. You can check the installed version of PhantomJS by running `phantomjs -v`.

If you are using Rails, you will need to add the following to `config/application.rb`.

    config.middleware.use Rack::Indexable

For regular Rack applications, use the following:

    require 'indexable'
    use Rack::Indexable

There is an example Rack application in the `example/` directory.

**(Optional)** Adding the following meta tag to the head section of your pages will opt you into the [AJAX crawling scheme](https://developers.google.com/webmasters/ajax-crawling/docs/specification), which the middleware uses in addition to checking the user agent in order to determine whether a request is coming from a crawler.

    <meta name="fragment" content="!">

