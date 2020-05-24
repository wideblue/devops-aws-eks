REGION ?= us-west-2

.PHONY: network	
network:
	@aws --region $(REGION) cloudformation create-stack \
	--stack-name  eks-network \
	--template-body file://EKS/vpc-network.yml \
    --parameters file://EKS/vpc-network-parameters.json \
    --capabilities CAPABILITY_IAM \

.PHONY: update-network	
update-network:
	@aws --region $(REGION) cloudformation update-stack \
	--stack-name  eks-network \
	--template-body file://EKS/vpc-network.yml \
    --parameters file://EKS/vpc-network-parameters.json \
    --capabilities CAPABILITY_IAM \


.PHONY: create-cluster	
create-cluster:
	@aws --region $(REGION) cloudformation create-stack \
	--stack-name  eks-cluster \
	--template-body file://EKS/eks-cluster.yaml \
    --parameters file://EKS/eks-cluster-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM \
	--disable-rollback


.PHONY: update-cluster	
update-cluster:
	@aws --region $(REGION) cloudformation create-stack \
	--stack-name  update-cluster \
	--template-body file://EKS/eks-cluster.yaml \
    --parameters file://EKS/eks-cluster-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM \

.PHONY: create-nodegroup
create-nodegroup:
	@aws --region $(REGION) cloudformation create-stack \
	--stack-name  eks-nodegroup \
	--template-body file://EKS/eks-nodegroup.yaml \
    --parameters file://EKS/eks-nodegroup-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM \
	--disable-rollback

.PHONY: update-nodegroup
update-nodegroup:
	@aws --region $(REGION) cloudformation update-stack \
	--stack-name  eks-nodegroup \
	--template-body file://EKS/eks-nodegroup.yaml \
    --parameters file://EKS/eks-nodegroup-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM \


# .PHONY: delete-eks-cluster	
# delete-eks-cluster:
# 	@aws --region $(REGION) cloudformation delete-stack --role-arn $(EKS_ADMIN_ROLE) --stack-name "$(CLUSTER_STACK_NAME)"