['action_view',
 'find',
 'gli',
 'json',
 'rainbow'].each do |d|
  require d
end

require_relative '../helpers/rails_erb_check'

include GLI::App

program_desc 'A simple lint tool for ERB Rails views.'

def get_erb_list(path)
  erb_files = []

  Find.find(path.to_s) do |f|
    next if FileTest.directory?(f)
    if /.*\.erb/.match(File.basename(f))
      erb_files << f
    end
  end

  erb_files
end

def check_files(erbs, options)
  files = {}

  erbs.each do |f|
    checker = RailsErbCheck::Checker.new(f)

    if checker.valid_syntax?
      puts Rainbow("#{f} => valid").green if options[:valid]
      files[f] = { invalid: false }
    else
      puts Rainbow("#{f} => invalid").red
      puts checker.error.message if options[:error]
      files[f] = {
        invalid: true,
        error: checker.error.message,
        backtrace: checker.error.backtrace
      }
    end
  end

  files
end

def export_json(hash, path)
  File.open(path, 'w') do |file|
    JSON.dump(hash, file)
  end
end

desc 'Check for syntax errors on views'
command :check do |c|
  c.switch [:v, :valid], {
    default_value: false,
    arg_name: 'valid',
    desc: 'print valid files along with invalid files'
  }

  c.switch [:e, :error], {
    default_value: false,
    arg_name: 'error',
    desc: 'print errors associated with invalid files'
  }

  c.flag [:j, :json], {
    default_value: nil,
    arg_name: 'json-file',
    type: String,
    desc: 'Export a json file with results, also exports valid files when coupled with -v'
  }

  c.flag [:p, :path], {
    default_value: Dir.getwd,
    arg_name: 'path',
    type: String,
    desc: 'specify the path that should be used as the root of the check'
  }

  c.action do |global_options, options|
    path = options[:path]
    puts Rainbow("Checking for files in current directory: #{path}").green

    erbs  = get_erb_list(path)
    files = check_files(erbs, options)

    valid   = files.reject { |file, info| info[:invalid] }
    invalid = files.select { |file, info| info[:invalid] }

    if options[:json]
      if options[:valid]
        export_json(files, options[:json])
      else
        export_json(invalid, options[:json])
      end
    end

    exit_now!("#{invalid.size} invalid files") if invalid.any?

    puts Rainbow("#{valid.size + invalid.size} files, no invalid files").yellow
  end
end

exit run(ARGV)
