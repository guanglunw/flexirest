module ActiveRestClient
  module Configuration
    module ClassMethods
      @@base_url = nil
      @lazy_load = false

      def base_url(value = nil)
        if value.nil?
          if @base_url.nil?
            @@base_url
          else
            @base_url
          end
        else
          value = value.gsub(/\/$/, '')
          @base_url = value
        end
      end

      def base_url=(value)
        ActiveRestClient::Logger.info "\033[1;4;32m#{name}\033[0m Base URL set to be #{value}"
        value = value.gsub(/\/+$/, '')
        @@base_url = value
      end

      def lazy_load!
        @lazy_load = true
      end

      def lazy_load?
        @lazy_load || false
      end

      def whiny_missing(value = nil)
        value ? @whiny_missing = value : @whiny_missing || false
      end

      def translator(value = nil)
        value ? @translator = value : @translator || nil
      end

      def _reset_configuration!
        @base_url         = nil
        @@base_url        = nil
        @whiny_missing    = nil
        @lazy_load        = false
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  class InvalidCacheStoreException < StandardError ; end
end
