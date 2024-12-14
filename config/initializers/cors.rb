Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins "http://localhost:3030,cool-boba-e226e1.netlify.app,incident-tracker.sentigroup.com,https://incident-tracker.sentigroup.com".split(",").map { |origin| origin.strip }
      resource "*",
               headers: :any,
               methods: %i[get post put patch delete options head]
    end
  end
