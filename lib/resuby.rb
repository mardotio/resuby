require 'erb'
require 'yaml'
require 'sass'

class Resuby
  attr_reader :name, :contact_info, :sections, :template, :profile

  def initialize
    @template = File.read(File.join(File.dirname(__FILE__), 'resuby/templates/resume.erb'))
  end

  def read_source(source)
    puts "Reading in data from #{source}"
    resume_data = YAML.load_file(source)
    @name = resume_data['name']
    @contact_info = resume_data['contact']
    @profile = resume_data['profile']
    @sections = resume_data.reject { |key, value| ['name', 'contact', 'profile'].include?(key) }
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

    scss_file = File.join(File.dirname(__FILE__), 'resuby/css/main.scss')
    render = Sass::Engine.new(File.read(scss_file), options).render
    Dir.mkdir(File.join(Dir.pwd, 'css'), 0755) unless File.directory?(File.join(Dir.pwd, 'css'))
    File.write(File.join(Dir.pwd, 'css/main.css'), render)
  end
end
