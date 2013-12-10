require 'indexable'

use Rack::Indexable

app = lambda do |env|
  [
    200,
    {'Content-Type' => 'text/html'},
    [
      "<html>",
        "<head>",
        "</head>",
        "<body>",
          "<script type='text/javascript'>",
            "document.write('Written from Javascript');",
          "</script>",
        "</body>",
      "</html>"
    ]
  ]
end

run app
