### TODO: 
- [ ] fix json schema so it includes all variables.tf
- [ ] remove "variables.tf" from schema field name

- [ ] use schema in APIM
...
- [ ] write subvendorIACProvisioner function app

## subvendor API generator

## subvendor IAC provisioner
containerized due to GitPython git dependency
containerization adds significant complexity due vscode not supporting containerized function app deployments,
and having to manage a container registry

## IAC
unless you have a CSP, EA, or MCA with Azure, terraform apply results in:
```
module.subscription.module.lz_vending.module.subscription[0].azapi_resource.subscription[0]: Creating...
╷
│ Error: Failed to create/update resource
│
│   with module.subscription.module.lz_vending.module.subscription[0].azapi_resource.subscription[0],
│   on .terraform/modules/subscription.lz_vending/modules/subscription/main.tf line 2, in resource "azapi_resource" "subscription":
│    2: resource "azapi_resource" "subscription" {
│
│ creating/updating Resource: (ResourceId "/providers/Microsoft.Subscription/aliases/my-subscription-alias" / Api Version "2021-10-01"): PUT
│ https://management.azure.com/providers/Microsoft.Subscription/aliases/my-subscription-alias
│ --------------------------------------------------------------------------------
│ RESPONSE 401: 401 Unauthorized
│ ERROR CODE: UserNotAuthorized
│ --------------------------------------------------------------------------------
│ {
│   "error": {
│     "code": "UserNotAuthorized",
│     "message": "User is not authorized to create subscriptions on this enrollment account"
│   },
│   "code": "UserNotAuthorized",
│   "message": "User is not authorized to create subscriptions on this enrollment account"
│ }
│ --------------------------------------------------------------------------------
│
╵
```

