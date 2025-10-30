 .PHONY: edit install uninstall clean dev prod graph-dev graph module

edit:
	@tuist edit

install:
	@tuist install

uninstall:
	@tuist clean

clean:
	@find . -type d -name "Derived" -not -path "*/Tuist/*" -prune -exec echo "Deleting: {}" \; -exec rm -rf {} \;
	@find . -type d -name "*.xcodeproj" -not -path "*/Tuist/*" -prune -exec echo "Deleting: {}" \; -exec rm -rf {} \;
	@find . -type d -name "*.xcworkspace" -not -path "*/Tuist/*" -prune -exec echo "Deleting: {}" \; -exec rm -rf {} \;

dev:
	@TUIST_ENV=dev tuist generate

prod:
	@tuist generate --no-binary-cache

graph-dev:
	@TUIST_ENV=dev tuist graph -t

graph:
	@tuist graph -t
