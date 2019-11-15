SHELL := /usr/bin/env bash

#.PHONY: plan_projects
plan_projects:
	pushd projects && \
		terraform init && \
		terraform plan && \
		popd

#.PHONY: plan
plan:
	source env.sh && \
		terraform init && \
		terraform plan -var-file terraform.tfvars

#.PHONY apply_projects
apply_projects:
	pushd projects && \
		terraform apply && \
		./make_env.sh && \
		popd

#.PHONY: apply
apply:
	source env.sh && terraform apply -var-file terraform.tfvars
