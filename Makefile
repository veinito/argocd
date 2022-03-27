all:
	make install
	make update

install:
	kubectl create ns argocd || true
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.2/manifests/install.yaml
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/applicationset/v0.4.1/manifests/install.yaml
	kubectl patch deployment argocd-server --patch-file ./server-patch.yaml


update:
	kubectl apply -n argocd -f ./applicationset.yaml

