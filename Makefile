dep:
	helm dependency update

verify:
	helm install . -n example-helm-app  --debug --dry-run