lint:
	swiftlint autocorrect --format

genLinuxTests:
	swift test --generate-linuxmain

test:
	genLinuxTests
	swift test

clean:
	
	swift package reset
	rm -rdf .build/
	rm Package.resolved
	rm .DS_Store

cleanArtifacts:
	swift package clean

genXcode:
	swift package generate-xcodeproj

latest:
	swift package update

resolve:
	swift package resolve

genXcodeOpen: genXcode
	open *.xcodeproj
	
