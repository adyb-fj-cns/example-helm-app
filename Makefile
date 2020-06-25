dep:
	helm dependency update

verify:
	helm install . -n example-helm-app  --debug --dry-run

create:
	argocd app create \
		--name example-helm-app \
		--repo https://github.com/adyb-fj-cns/example-helm-app.git \
		--dest-server https://kubernetes.default.svc \
		--dest-namespace default \
		--path . \
		--sync-policy automated \

sync:
	argocd app sync example-helm-app

delete:
	argocd app delete example-helm-app --cascade

get:
	argocd app get example-helm-app

list:
	argocd app list

list-rollouts:
	kubectl get rollouts

promote:
	kubectx minikube
	kubectl argo rollouts promote example-helm-app-bluegreen
	kubectl argo rollouts promote example-helm-app-bluegreen2
	kubectx argocd

# Currently the ArgoCD cascade delete isnt deleting Rollout resources in apps
delete-rollouts:
	kubectl delete rollout example-helm-app-bluegreen
	kubectl delete rollout example-helm-app-bluegreen2
