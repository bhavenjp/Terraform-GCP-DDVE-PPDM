# Terraform-GCP-DDVE-PPDM

**Objective**: Provision PowerProtect Data Domain, PowerProtect Data Manager and configure initial settings


**Prerequisite**: This is setup and tested on a CentOS VM with following installed
1. GCP SDK
2. Terraform
3. Ansible


**Steps**:
- terraform init
- terraform plan
- terraform apply


**Outcome**: 
1. DDVE provisioning on GCP
2. PPDM provisioning on GCP
3. Configuration of DDFS, DDBoost as well integration with PPDM as target storage


