require 'action_view'

module RailsErbCheck
  class Checker
    CHECKER =
      if defined?(ActionView::Template::Handlers::ERB::Erubi)
        ActionView::Template::Handlers::ERB::Erubi
      else
        ActionView::Template::Handlers::Erubis
      end

    attr_reader :error

    def initialize(erb_path)
      @erb = File.read(erb_path)
    end

    def valid_syntax?
      begin
        CHECKER.new(@erb).result
      rescue SyntaxError => e
        @error = e
        return false
      rescue Exception
        return true
      end
    end

  end
end
