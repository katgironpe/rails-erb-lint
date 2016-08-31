require 'action_view'

module RailsErbCheck
  class Checker
    attr_reader :error

    def initialize(erb_path)
      @erb = File.read(erb_path)
    end

    def valid_syntax?
      begin
        ActionView::Template::Handlers::Erubis.new(@erb).result
      rescue SyntaxError => e
        @error = e
        return false
      rescue Exception
        return true
      end
    end

  end
end
