{{ salt['slsutil.banner']() }}

require 'readline'

if !Readline::VERSION.include?('EditLine')
  primary_color   = "\033[38;5;24m"
  secondary_color = "\033[38;5;45m"
  reset_color     = "\033[39m"
else
  primary_color   = ''
  secondary_color = ''
  reset_color     = ''
end

Pry.config.theme       = 'pry-siberia-16'
Pry.config.prompt_name = primary_color + `hostname -s`.chomp + reset_color
Pry.config.prompt      = Pry::Prompt.new('arx', 'arx',[
  proc { |target_self, nest_level, pry|
    "#{pry.config.prompt_name}#{primary_color}(#{secondary_color}#{Pry.view_clip(target_self)}#{primary_color})#{reset_color}#{":#{nest_level}" unless nest_level.zero?} "
  },
  proc { |target_self, nest_level, pry|
    "#{pry.config.prompt_name}#{primary_color}(#{secondary_color}#{Pry.view_clip(target_self)}#{primary_color})#{reset_color}#{":#{nest_level}" unless nest_level.zero?}* "
  }
])

# vim: ft=ruby
