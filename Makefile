bootstrap:
	brew update
	brew bundle install
	bundle install
	# Virtual macOS environments of GitHub Actions might have SwiftLint preinstalled
	which swiftlint &>/dev/null || brew install swiftlint
