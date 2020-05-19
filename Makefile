REGION ?= us-east-1

.PHONY: network	
network:
	@aws --region $(REGION) cloudformation create-stack \
	--stack-name  eks-network \
	--template-body file://EKS/vpc-network.yml \
    --parameters file://EKS/vpc-network-parameters.json \
    --capabilities CAPABILITY_IAM \



# .PHONY: delete-eks-cluster	
# delete-eks-cluster:
# 	@aws --region $(REGION) cloudformation delete-stack --role-arn $(EKS_ADMIN_ROLE) --stack-name "$(CLUSTER_STACK_NAME)"