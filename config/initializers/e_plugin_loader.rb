puts "plugin loader..."

plugin_dirs = %w{
  easy-authentication
}

glob_string = "../../../plugins/{#{plugin_dirs.join(',')}}/init.rb"
file_expander = File.expand_path(glob_string, __FILE__)
# puts "__FILE__ : #{__FILE__}"
# puts "file_expander : #{file_expander}"
file_list = Dir.glob( file_expander )
# puts "file_list : #{file_list}"

file_list.each do |plugin|
  # puts "loading plugin: #{plugin.inspect}"
  # require_relative plugin
  require plugin
end