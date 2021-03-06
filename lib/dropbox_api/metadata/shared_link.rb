# frozen_string_literal: true

module DropboxApi::Metadata
  class SharedLink < Base
    VALID_KEYS = %i[url password].freeze

    def initialize(param)
      @shared_link =
        case param
        when String
          { url: param }
        when Hash
          param
        end

      check_validity
    end

    def check_validity
      raise ArgumentError, 'Missing `:url` option' if @shared_link[:url].nil?

      @shared_link.each_key do |key|
        unless VALID_KEYS.include? key
          raise ArgumentError,
                "Invalid option `#{key.inspect}`"
        end
      end
    end

    def to_hash
      @shared_link
    end

    private

    def valid_keys; end
  end
end
