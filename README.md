Here is the step-by-step guide to deploying Three tier architecture on Amazon Web Services using Terraform.

Before you start, ensure that you have the following prerequisites:

   1. AWS account, IAM user with proper permission, and configured AWS CLI.
   2. Terraform installed on your local machine. 
   3. Familiarity with the basics of Terraform, including how to write Terraform configuration files.
   5. Install Github.
   6. Have Visual Studio Code or similar IDE.
   7. Connect to remote host using ssh keys.

STEPS

Follow these steps-by-step instructions to deploy a Three-Tier Architecture on AWS using Terraform:
     
Step 1:

     1. Open a terminal or command prompt on your local machine.
     2. Clone the repository containing the Terraform configuration files.
     3. Change into the project directory.

Step 2: Configure Terraform Variables and Domain name.

     1. Create the project directory.
     2. Add the Terraform configuration file named 'var.tf'
     3. Modify the values of the variables according to your requirements. 
     4. Change your domain.

 Step 3: Initialize Terraform

     1. To initialize Terraform and download the required providers run the command:
             terraform init

 Step 4. Review and Validate the Configuration

       1. To review changes that Terraform will make run the command bellow:
             terraform plan

 Step 5. Deploy the Infrastructure

       1. To deploy the infrastructure run the command bellow:
             terraform apply
        2. Type "yes" to confirm and start the deployment. 

 Step 6.    Destroy the Infrastructure
         1. To tear down the infrastucture and remove all resources created by Terraform run the comman bellow:
               terraform destroy
          
