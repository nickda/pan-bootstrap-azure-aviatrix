# Terraform Module - PAN Bootstrap in Azure for Aviatrix


Terraform Module to Bootstrap Palo Alto Networks VM-Series Firewall on Azure for Aviatrix Firenet.
Reference: https://docs.aviatrix.com/HowTos/bootstrap_example.html

## Usage with minimal customisation
Default admin credential: admin/Aviatrix123#
Default api user credential: admin-api/Aviatrix123#

```hcl
module "pan-bootstrap-azure-aviatrix" {
  source = "./modules/pan-bootstrap-azure-aviatrix"

  azure_location              = <location>
  create_admin_api            = true
}
```

This is an Azure version of the following module for AWS by Bayu Wibowo:
https://github.com/bayupw/terraform-aws-pan-bootstrap-aviatrix/

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/nickda/pan-bootstrap-azure-aviatrix/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/nickda/pan-bootstrap-azure-aviatrix/tree/master/LICENSE) for full details.