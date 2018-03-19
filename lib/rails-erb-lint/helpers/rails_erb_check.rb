require 'action_view'

module RailsErbCheck
  class Checker
    CHECKER =
      if defined?(ActionView::Template::Handlers::ERB::Erubi)
        ->(erb) { eval ActionView::Template::Handlers::ERB::Erubi.new(erb).src }
      else
        ->(erb) { ActionView::Template::Handlers::Erubis.new(erb).result }
      end

    attr_reader :error

    def initialize(erb_path)
      @erb = File.read(erb_path)
    end

    def valid_syntax?
      begin
        CHECKER.call(@erb)
      rescue SyntaxError => e
        @error = e
        return false
      rescue Exception
        return true
      end
    end

  end
end
