require 'erb'

module Napa
  class << self

    def secret_key_base
      @secret_key_base
    end

    def secret_key_base=(key)
      @secret_key_base = key
    end

  end
end

Napa.secret_key_base = YAML.load(ERB.new(File.read('./config/secrets.yml')).result)['secret_key_base'][Napa.env]
