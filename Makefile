bootstrap:
	brew update
	brew doctor
	# Virtual macOS environments of GitHub Actions might have SwiftLint preinstalled
	rm '/usr/local/bin/swiftlint'
	brew bundle install
	bundle install
