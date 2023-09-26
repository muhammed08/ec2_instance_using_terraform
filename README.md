Terraform script to create an EC2 instance that can access a secret manager.

Pre requisites:
install terraform

create aws access key and secret access key and save it in env variable (
export AWS_ACCESS_KEY=
,export AWS_SECRET_ACCESS_KEY=)

create a Key pair for logging into EC2 instance. Create a security group in vpc that access ssh connection.
this is required to ssh into the ec2 instance created. The groupid is then mentioned while creating the ec2 instance

AWS resources created:
1) create a key_pair resource for ec2 instance
2) create a aws secret manager place holder
3) create a iam role
4) create policy to access iam role
5) attach the policy to the role
6) create an instance profile for the ec2 instance from the role
7) create an ec2 instance using the key pair and the instance profile



The springboot application created in ApiRequest Project will be deployed in the ec2 instance. the secret manager
is used to store the keystore password. Note that the keystore password is saved manually in aws console



