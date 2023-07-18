### OPA  with terraform

### Instructions
---

* Step 1: Open `Terminal` and provision `AWS` credentials

```bash
asectl init aws
```
* Step 2: Clone the repository
```bash
cd /root
```

```bash
git clone https://github.com/appsecengineer/aws-tags-opa-terraform.git
```

* Step 3: Go to cloned respository directory

```bash
cd aws-tags-opa-terraform
```

### Create new repository in your github account 

> Note: You need to login into your github account

* Step 1:  Open browser and create New repository or [Click here](https://github.com/new)

* Step 2: In the `Repository name` enter this name
```bash
aws-tags-opa-terraform
```
* Step 3: Now copy the repository `URL`

```bash
https://github.com/<your-github-username>/aws-tags-opa-terraform.git
```

![](https://prod-bucket-for-documentation-449630918120-dont-delete.s3.us-west-2.amazonaws.com/supply-chain-attacks/reusables/create-new-repo-copy-url.gif)

* Step 4: Under your repository name, click Settings. If you cannot see the "Settings" tab, select the dropdown menu, then click Settings.

* Step 5: Select Actions and click on General then Under "Workflow permissions", choose GITHUB_TOKEN to have read and write access for all scopes and also check the `Allow GitHub Actions to create and approve pull requests`.

### Now comeback to Terminal

* Step 1: Change Directory

```bash
cd /root/aws-tags-opa-terraform
```

* Step 2: Check the existing repo owner info

```bash
git remote -v 
```

> It will show appsecengineer 

* Step 3: Let's change the repository owner

```bash
git remote set-url origin <paste the copied repository URL>
```

> Example: git remote set-url origin https://github.com/<your-github-username>/aws-tags-opa-terraform.git

* Step 4: Now check the repository owner

```bash
git remote -v 
```
> It show your github username


### Now Lets set the Environment variable in Github Project

* Expand `Explorer` in the web IDE
* Go to `aws-cred.txt` file.
* Copy the `aws_access_key_id` and `aws_secret_access_key` and paste it somewhere

* Go back to browser and click on newly created repo `settings` 
  - Select `secrets` from left hand side menu 
  - Click on `actions`
  - Click on `New repository secret`


* Now let's add a secret
- Secret Name 

```bash
AWS_ACCESS_KEY_ID
```
- Please add Access key in the `Value` field

```bash
AKIAIOSFODNN7EXAMPLE
```
> Enter the copied `aws_access_key_id` from `aws-cred.txt` in the `Value` field

- Click `Add secret` button

- Secret Name 

```bash
AWS_SECRET_ACCESS_KEY
```
- Please add Secret key in the `Value` field

```bash
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

> Enter the copied `aws_secret_access_key` from `aws-cred.txt` in the `Value` field


- Click `Add secret` button

![](https://prod-bucket-for-documentation-449630918120-dont-delete.s3.us-west-2.amazonaws.com/supply-chain-attacks/gh-actions-information-disclosure/single-secrets.gif)

### Generate Personal Access Token 

* Step 1: Generate `personal access token` for authentication to your github account.
> using this token we can push the code into github repository
![](https://prod-bucket-for-documentation-449630918120-dont-delete.s3.us-west-2.amazonaws.com/supply-chain-attacks/reusables/pat_gh_actions.gif)

* Step 2: Copy the `Personal access token` and paste it somewhere

### Let's create the s3 bucket and update it in provider.tf

* Let's generate the `s3 bucket name` using `uuid` command

```bash
export BUCKET_NAME=$(uuid)-tfstate
```

* Let's create the `s3 bucket` using `aws cli`

```bash
aws s3api create-bucket --bucket $BUCKET_NAME --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
```

* Let's update the `s3 bucket name` in `provider.tf` file

```bash
sed -i -e 's/ase-terraform-state-bucket/'"$(BUCKET_NAME)"'/g' /root/aws-tags-opa-terraform/provider.tf
```

### Now come back to Terminal 

* Change directory
```bash
cd /root/aws-tags-opa-terraform
```

* Commit the code to the repo

```bash
git add -A
```
```bash
git commit -m "Updated  S3 bucket value in provider.tf file"
```

* Push the code into `main` branch

```bash
git push -u origin main
```

> Note: It will ask username and password, In username enter your github username and in the password section enter copied `Personal access token`



### Go to browser and Let's look at the results of the deployment

* Click on `Actions`  tab

* Under the Workflow click on `Updated  S3 bucket value in provider.tf file`
> Refresh the page if required 

* click on `build`

* Wait until the `Actions completes` and view the results
![](https://prod-bucket-for-documentation-449630918120-dont-delete.s3.us-west-2.amazonaws.com/supply-chain-attacks/gh-actions-information-disclosure/build-actions-info-disclosure.gif)


> You will have the following output stating set-output name=result::OPA policy not satsfied, Please ensure tags are created according to organization policy

### Let's push the code again to the repo

* Change directory

```bash
cd /root/aws-tags-opa-terraform
```

* Comment the code in resource.tf file and uncomment the code in resource_valid.tf file under /root/aws-tags-opa-terraform directory


* Commit the code to the repo

```bash
git add -A
```
```bash
git commit -m "Updated resource.tf file"
```

* Push the code into `main` branch

```bash
git push -u origin main
```

> Note: It will ask username and password, In username enter your github username and in the password section enter copied `Personal access token`

### Go to browser and Let's look at the results of the deployment

* Click on `Actions`  tab

* Under the Workflow click on `Updated resource.tf file`
> Refresh the page if required

* click on `build`

* Wait until the `Actions completes` and view the results

> You will have the following output stating set-output name=result::OPA policy satsfied, terraform stack deployed succesfully



### Teardown

* Step 1: Open GitHub on the Browser and click on the repo

* Step 2: Click on `Settings` Scroll until the bottom you will find the `Delete this repository`
