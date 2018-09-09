require 'resuby/cli/banners'
require 'resuby/cli/exe'
require 'optimist'

module Resuby::CLI
  def self.run
    Resuby::CLI.options
  end

  def self.options
    Resuby::CLI.global_options
    @subcommand = ARGV.shift
    Resuby::CLI.subcommand_options
    Resuby::CLI.execute
  end

  def self.global_options
    @global_opts = Optimist::options do
      banner Resuby::CLI::RESUBY_BANNER
      version "resuby version #{Resuby::VERSION}"
      stop_on %w(generate)
    end
  end

  def self.subcommand_options
    case @subcommand
    when 'generate'
      @opts = Optimist::options do
        banner Resuby::CLI::GENERATE_BANNER
        opt :output, 'Output file for generated HTML', default: File.join(Dir.pwd, 'resume.html')
        opt :data, 'Path to file containing data for the resume', default: File.join(Dir.pwd, 'resume.yaml')
      end
    else
      Optimist::die "Unknonwn subcommand #{@subcommand.inspect}"
    end
  end

  def self.execute
    case @subcommand
    when 'generate'
      Resuby::CLI.generate
    else
      Optimist::die "Unknonwn subcommand #{@subcommand.inspect}"
    end
  end
end
