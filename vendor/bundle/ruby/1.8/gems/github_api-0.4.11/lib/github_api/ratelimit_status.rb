module Github
  class RatelimitStatus
    include Github::Constants

    attr_reader :ratelimit_limit, :ratelimit_remaining

    def initialize(env)
      @env = env
      @ratelimit_limit     = env[:response_headers][RATELIMIT_LIMIT]
      @ratelimit_remaining = env[:response_headers][RATELIMIT_REMAINING]
    end

    def ratelimit_reset_time
      @ratelimit_reset_time ||= Time.parse(@env[:reponse_headers]['date'])
    end
  end
end
