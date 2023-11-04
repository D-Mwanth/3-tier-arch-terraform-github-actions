### Automating 3-tier infrastructure provisionig with Terraform and AWS using Github Actions

Infrastructure provisioning using Terraform on AWS.

## Establishing remote state storage
- Create github repo where to base your infra provisioning code.
- Clone this Repo
- Add service account credentials on github repo secrets
- In the clones repo, add `src` dir. This where we shall store our terraform configuration files.
- Inside the src dir, create main.tf file. This is the main terraform file for our project. 
- Declare the required terraform version and provider as well as provider version and declare provider.
- Inside the src dir create another dir called modules.
```bash
mkdir modules
```
- Inside modules, create another dir called `tf-state`
- Inside the `tf-state` create a file, `main.tf`. Add terraform block.
- Create another file called, `tf-state.tf` and add the following blocks:
    - create resource to provision s3 with versioning and server site encryption
0 Still inside the tf-state dir, add a variables file and declare the necceassary variable for `tf-state.tf`.

Got to the root folder of terraform conguration file, that's, `src` and add the module for terraform state.

- The initialize terraform project, `terraform init`
- Format configuration files, `terraform fmt -recursive`
- Run `terraform validate` to ensure there is no error in our code
- Run `terraform plan` to see what resources will be created
- Run `terraform apply -auto-approve` to provision resources on aws.

Not that we are assuming you already have authentication to get into aws cloud and and create resouces, so that is not cover in this project.

- If everything runs as expected you should get your reasource create.
```bash
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```
You can log in to aws console and verify your resources were provisioned.

### How to create infrustructure in multiple enviroments (dev, test, prod)

- The infrusture we just created, terraform is using local backent. This not what we want, we need to store our environ state in s3. So we add s3 as our backend inside the terraform block.

```bash
    bucket         = "mwan-daniel-tf-state-backen-ci-cd"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
```

Format the configureation file and initiate to buckent to be established. Confirm with yes to copy the state into the new backend.
- Then apply for the changes.
- Nothing will be created. All that will happen is that the local state will be copied to the cloud backend.

Now with terraform project state intialized and backend set as s3, we can now make our initial commit and push to the github repo.

For development purpose we are only using the main branch, this wont be the case in production scenario but for development purpose, this will be the case in production settings as you will need to use branching and execute on merge to main branch for deployment.

Now, what we plan to do here is to deploy a 3-tier application architecute usign github actions and terrafrom on AWS cloud.




