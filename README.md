# nodejs-azure

TODO: Enter the cookbook description here.

- When getting the error about cant export the policy file, just make a new cookbook and copy everything over!

### Creates a service principal
- az ad sp create-for-rbac

### Runs kitchen test on Azure resources
- KITCHEN_YAML=kitchen.cloud.yml kitchen test

### Creates an immutable image with packer
- packer build packer.json  
