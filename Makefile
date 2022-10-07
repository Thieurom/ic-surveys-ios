bootstrap:
	brew update
	brew bundle install
	# Virtual macOS environments of GitHub Actions might have SwiftLint preinstalled
	which swiftlint &>/dev/null || brew bundle install swiftlint
	bundle config set --local path vendor/bundle
	bundle install
