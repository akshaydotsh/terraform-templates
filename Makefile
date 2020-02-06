deps:
	chmod +x scripts/install_terraform.sh
	chmod +x scripts/run.sh
	chmod +x scripts/destroy.sh
	sudo sh scripts/install_terraform.sh

acm:
	sh scripts/run.sh AWS/acm

destroy-acm:
	sh scripts/destroy.sh AWS/acm

vpc:
	sh scripts/run.sh AWS/custom-vpc

destroy-vpc:
	sh scripts/destroy.sh AWS/custom-vpc

fargate:
	sh scripts/run.sh AWS/fargate

destroy-fargate:
	sh scripts/destroy.sh AWS/fargate

static-webhosting:
	sh run.sh AWS/static-webhosting

destroy-static-webhosting:
	sh scripts/destroy.sh AWS/static-webhosting