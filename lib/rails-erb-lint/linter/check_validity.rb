#!/usr/bin/env ruby
require 'gli'
require 'action_view'
require_relative '../helpers/rails_erb_check'

include GLI::App

program_desc 'A simple lint tool for ERB Rails views.'

desc 'Check for syntax errors on views'
command :check do |c|
  c.action do |global_options,options,args|
    valid = []
    invalid = []
    args.each do |filepath|
      if RailsErbCheck.valid_syntax?(File.read(filepath))
        p "#{filepath} => valid"
        valid << filepath
      else
        p "#{filepath} => invalid"
        invalid << filepath
      end
    end

    p "#{valid.size + invalid.size} files, #{invalid.size} invalid files"
    if invalid.size > 0
      invalid.each do |f|
        p "Please edit #{f} and fix errors."
      end
    end
    abort
  end
end

exit run(ARGV)
