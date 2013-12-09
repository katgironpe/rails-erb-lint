require 'action_view'

module RailsErbCheck
  def self.valid_syntax?(erb)
    begin
      ActionView::Template::Handlers::Erubis.new(erb).result
    rescue SyntaxError
      return false
    rescue Exception
      return true
    end
  end
end