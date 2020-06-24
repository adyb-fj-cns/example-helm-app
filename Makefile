dep:
	helm dependency update

verify:
	helm install . -n example-helm-app  --debug --dry-run

create-app:
	argocd app create \
		--name example-helm-app \
		--repo https://github.com/adyb-fj-cns/example-helm-app.git \
		--dest-server https://192.168.64.5:8443 \
		--dest-namespace default \
		--path . \
		--sync-policy automated \

sync-app:
	argocd app sync example-helm-app

delete-app:
	argocd app delete example-helm-app
