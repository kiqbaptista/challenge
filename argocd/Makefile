argocd:
	kubectl create ns argocd
	kubectl -n argocd apply -f install/argocd.yaml
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

clean:
	kubectl -n argocd delete -f install/argocd.yaml
	kubectl delete ns argocd

install: argocd
