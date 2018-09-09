module Resuby::CLI
  def self.generate
    resume = Resuby::Resume.new
    resume.read_source(@opts[:data])
    resume.save_resume(@opts[:output])
    resume.compile_styles
  end
end
