module Indexable
  class Railtie < Rails::Railtie
    initializer "indexable.insert_middleware" do |app|
      app.config.middleware.use Indexable::Middleware
    end
  end
end
