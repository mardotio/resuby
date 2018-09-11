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
      stop_on %w(generate init)
    end
  end

  def self.subcommand_options
    case @subcommand
    when 'generate'
      @opts = Optimist::options do
        banner Resuby::CLI::GENERATE_BANNER
        opt :data, 'Path to file containing data for the resume', default: File.join(Dir.pwd, 'resume.yaml')
        opt :json, 'Read in data file as a JSON formatted file'
        opt :output, 'Output file for generated HTML', default: File.join(Dir.pwd, 'resume.html')
        opt :yaml, 'Read in data file as a YAML formatted file'
      end
      Optimist::die 'Data file connot be JSON and YAML' if @opts[:json] && @opts[:yaml]
    when 'init'
      @opts = Optimist::options do
        banner Resuby::CLI::INIT_BANNER
        opt :force, 'Force overwrite of data file if already present'
        opt :json, 'Outputs data template in JSON format'
        opt :output, 'Path to file where data template should be placed', required: true, type: :string
        opt :yaml, 'Outputs data template in YAML format'
      end
      Optimist::die 'Cannot output two different formats at the same time' if @opts[:json] && @opts[:yaml]
      Optimist::die 'You must specify an output format' unless @opts[:json] || @opts[:yaml]
    else
      Optimist::die "Unknonwn subcommand #{@subcommand.inspect}"
    end
  end

  def self.execute
    case @subcommand
    when 'generate'
      Resuby::CLI.generate
    when 'init'
      Resuby::CLI.init
    else
      Optimist::die "Unknonwn subcommand #{@subcommand.inspect}"
    end
  end
end
