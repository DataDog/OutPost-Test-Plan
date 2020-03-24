cluster: 
	eksctl create cluster -f eks_cluster.yaml

deploy: deploy-iam deploy-falco deploy-fluent deploy-app

deploy-iam:
	chmod +x iam/role.sh && ./iam/role.sh

deploy-falco:
	helm install falco --set falco.jsonOutput=true --set image.tag=0.17.1 stable/falco

deploy-fluent:
	kubectl apply -f fluent-bit/

deploy-app:
	kubectl apply -f app/ecsdemo-nodejs/kubernetes/
	kubectl apply -f app/ecsdemo-crystal/kubernetes/
	kubectl apply -f app/ecsdemo-frontend/kubernetes/

clean: clean-falco clean-fluent clean-app

clean-falco:
	helm del falco

clean-fluent:
	kubectl delete -f fluent-bit/

clean-app:
	kubectl delete -f app/ecsdemo-nodejs/kubernetes/
	kubectl delete -f app/ecsdemo-crystal/kubernetes/
	kubectl delete -f app/ecsdemo-frontend/kubernetes/

clean-cluster:
	eksctl delete cluster -n outposts --region us-east-2

