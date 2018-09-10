require 'erb'
require 'json'
require 'yaml'
require 'sass'
require 'resuby/version'

class Resuby::Resume
  attr_reader :name, :contact_info, :sections, :template, :profile

  def initialize
    @template = File.read(File.join(__dir__, '../templates/resume.erb'))
  end

  def read_source(source, extension = nil)
    puts "Reading in data from #{source}"
    ext = extension || File.extname(source)
    resume_data =
    case ext
    when '.yaml', '.yml'
      YAML.load_file(source)
    when '.json'
      JSON.parse(File.read(source))
    else
      puts 'File type not supported'
      exit 1
    end
    store_data(resume_data)
  end

  def store_data(data)
    @name = data['name']
    @contact_info = data['contact']
    @profile = data['profile']
    @sections = data.reject { |key, value| ['name', 'contact', 'profile'].include?(key) }
  end

  def render
    ERB.new(self.template, nil, '-').result( binding )
  end

  def save_resume(file)
    puts "Saving your resume at #{file}"
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

  def compile_styles
    options = {
      cache: true,
      syntax: :scss,
      style: :compressed,
    }

    scss_file = File.join(__dir__, '../css/main.scss')
    render = Sass::Engine.new(File.read(scss_file), options).render
    Dir.mkdir(File.join(Dir.pwd, 'css'), 0755) unless File.directory?(File.join(Dir.pwd, 'css'))
    File.write(File.join(Dir.pwd, 'css/main.css'), render)
  end
end
