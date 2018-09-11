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

  def self.init
    unless @opts[:force]
      if File.file?(@opts[:output]) && File.size?(@opts[:output])
        print "#{@opts[:output]} already exists, would you like to proceed (Y/N)? "
        proceed = gets.chomp
        unless proceed == 'Y'
          warn 'Aborted!'
          exit 1
        end
      end
    end
    template = {
      'name'=> 'Bob Smith',
      'contact'=> [
        '(321) 321-4321',
        'bob.smith@resuby.com',
      ],
      'profile'=> 'This section is optional, but it is a good place to write a short paragraph about yourself.',
      'experience'=> [
        {
          'title'=> 'Position 1',
          'subtitle'=> 'Company 1',
          'desc'=> 'Jan 2018 - present',
          'data'=> [
            'Responsibility/accomplishment 1',
            'Responsibility/accomplishment 2',
            'Responsibility/accomplishment 3',
          ],
        },{
          'title'=> 'Position 2',
          'subtitle'=> 'Company 2',
          'desc'=> 'Jan 2017 - Jan 2018',
          'data'=> [
            'Responsibility/accomplishment 1',
            'Responsibility/accomplishment 2',
            'Responsibility/accomplishment 3',
          ],
        }
      ],
      'projects'=> [
        {
          'title'=> 'Project 1',
          'subtitle'=> 'Company 1',
          'desc'=> 'Aug 2018 - present',
          'data'=> [
            'Responsibility/accomplishment 1',
            'Responsibility/accomplishment 2',
            'Responsibility/accomplishment 3',
          ]
        },{
          'title'=> 'Project 2',
          'subtitle'=> 'Company 2',
          'desc'=> 'Mar 2017 - Jan 2018',
          'data'=> [
            'Responsibility/accomplishment 1',
            'Responsibility/accomplishment 2',
            'Responsibility/accomplishment 3',
          ],
        }
      ],
      'education'=> [
        {
          'title' => 'Some University',
          'desc' => 'Aug 2010 - May 2014',
          'data' => [
            'Degree, GPA',
          ],
        }
      ],
      'skills'=> [
        {
          'desc' => 'Languages',
          'data' => [
            'Ruby, Python',
            'HTML, CSS, Javascript',
          ],
        },{
          'desc' => 'Tools',
          'data' => [
            'Tool 1, Tool 2',
            'Tool 3, Tool 4',
          ],
        },
      ],
    }
    puts "Storing template at #{@opts[:output]}"
    if @opts[:yaml]
      File.open(@opts[:output], 'w') { |f| f.puts template.to_yaml }
    elsif @opts[:json]
      File.open(@opts[:output], 'w') { |f| f.puts JSON.pretty_generate(template) }
    else
      puts 'Template format is not supported'
      exit 1
    end
  end
end
