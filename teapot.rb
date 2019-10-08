
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "3.0"

define_target "executor-unix" do |target|
	target.priority = 10
	
	target.depends :platform, public: true
	
	target.provides :debugger => "Debugger/none"
	
	target.provides "Debugger/none" do
		define Rule, "run.executable" do
			input :executable_file
			
			parameter :prefix, implicit: true do |arguments|
				arguments[:prefix] ||= File.dirname(arguments[:executable_file])
			end
			
			parameter :arguments, optional: true
			
			apply do |parameters|
				run!(
					parameters[:executable_file],
					*parameters[:arguments],
					chdir: parameters[:prefix],
					foreground: true
				)
			end
		end
	end
end
