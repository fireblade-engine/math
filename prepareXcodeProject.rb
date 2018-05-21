#!/usr/bin/env ruby

# Tweak the .xcodeproj after creating with the swift package manager.

# Resources: 
# https://stackoverflow.com/questions/41527782/swift-package-manager-and-xcode-retaining-xcode-settings/41612477#41612477
# https://stackoverflow.com/questions/20072937/add-run-script-build-phase-to-xcode-project-from-podspec
# https://github.com/IBM-Swift/Kitura-Build/blob/master/build/fix_xcode_project.rb
# http://www.rubydoc.info/github/CocoaPods/Xcodeproj/Xcodeproj%2FProject%2FObject%2FAbstractTarget%3Anew_shell_script_build_phase
# http://www.rubydoc.info/github/CocoaPods/Xcodeproj/Xcodeproj/Project/Object/AbstractTarget
# https://gist.github.com/niklasberglund/129065e2612d00c811d0
# https://github.com/CocoaPods/Xcodeproj
# https://stackoverflow.com/questions/34367048/how-do-you-automate-do-copy-files-in-build-phases-using-a-cocoapods-post-insta?rq=1
# https://stackoverflow.com/a/41612477/6043526
# https://stackoverflow.com/a/20505234/6043526

require 'xcodeproj'

path_to_project = Dir.glob('*.xcodeproj').first

project = Xcodeproj::Project.open(path_to_project)

resources_folder_path = "#{Dir.pwd}/Resources"
resources_folder_ref = project.reference_for_path(resources_folder_path)


# add build phases
project.targets.each do |target|

	#if target.name == 'Fireblade-macOS' || target.name == 'Fireblade-iOS'

		puts "Add Run Shell Script Phase: Swiftlint to #{target}"
		swiftlint_phase = target.new_shell_script_build_phase("Run Swiftlint")
		swiftlint_phase.shell_script = """
set -e
if which swiftlint >/dev/null; then
	swiftlint autocorrect
	swiftlint
else
	echo 'warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint'
fi
"""

	#end
end

project.save()