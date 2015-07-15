class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  add_swagger_documentation
end

