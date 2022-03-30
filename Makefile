all:
	make install/argocd
	make install/cli
	make update/apps

install/argocd:
	kubectl create ns argocd || true
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.2/manifests/install.yaml
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/applicationset/v0.4.1/manifests/install.yaml
	kubectl patch deployment argocd-server --patch-file ./server-patch.yaml

install/cli:
	sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
	sudo chmod +x /usr/local/bin/argocd

update/apps:
	kubectl apply -n argocd -f ./applicationset.yaml

