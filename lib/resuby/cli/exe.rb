module Resuby::CLI
  def self.generate
    resume = Resuby::Resume.new
    ext =
      if @opts[:yaml]
        '.yaml'
      elsif @opts[:json]
        '.json'
      else
        nil
      end
    resume.read_source(@opts[:data], ext)
    resume.save_resume(@opts[:output])
    resume.compile_styles
  end
end
