require 'gli'
require 'action_view'
require 'find'
require_relative '../helpers/rails_erb_check'

include GLI::App

program_desc 'A simple lint tool for ERB Rails views.'

desc 'Check for syntax errors on views'
command :check do |c|
  c.action do |global_options,options|
    valid = []
    invalid = []
    erb_files = []

    path = Dir.getwd
    p "Checking for files in current directory: #{path}"

    Find.find(path.to_s) do |f|
      next if FileTest.directory?(f)
      if /.*\.erb/.match(File.basename(f))
        erb_files << f
      end
    end

    erb_files.each do |f|
      if RailsErbCheck.valid_syntax?(File.read(f))
        p "#{f} => valid"
        valid << f
      else
        p "#{f} => invalid"
        invalid << f
      end
    end

    p "#{valid.size + invalid.size} files, #{invalid.size} invalid files"
    if invalid.size > 0
      invalid.each do |f|
        p "Please edit #{f} and fix errors."
      end
    end

  end
end

exit run(ARGV)
