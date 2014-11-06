require 'indexable'

require 'minitest/autorun'
require 'rack/test'

class IndexableTest < Minitest::Test
  include Rack::Test::Methods

  def default_app
    @content ||= "OK"
    lambda do |env|
      [200, {'Content-Type' => 'text/html'}, [@content]]
    end
  end

  def app
    @app ||= Indexable::Middleware.new(default_app)
  end

  def test_crawler_detection
    user_agents = {
      :bot => ["Twitterbot", "facebookexternalhit/1.1 (+http(s)://www.facebook.com/externalhit_uatext.php)", "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)", "SAMSUNG-SGH-E250/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) MMP/2.0 (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)", "DoCoMo/2.0 N905i(c100;TB;W24H16) (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)", "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot-Mobile/2.1; +http://www.google.com/bot.html)"],
      :browser => ["Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0"]
    }
    @content = "<html><head></head><body><script>document.write('test');</script></body></html>"
    threads = []
    user_agents.each do |key, value|
      value.each do |ua|
        threads.push Thread.new {
          get "http://example.org/", {}, {"HTTP_USER_AGENT" => ua}
          response = last_response.body.strip
          if key == :bot
            assert_equal "<html><head></head><body><script>document.write('test');</script>test</body></html>", response
          else
            assert_equal @content, response
          end
        }
      end
    end
    threads.each {|t| t.join }
  end
end
