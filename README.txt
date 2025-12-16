Steps for cloud:

- install terrafrom
- install aws cli
- create a user with acces to s3 and ec2
- also create a key for your ec2 change that name to the name in variables.tf
- in variables.tf change the bucket name do this also in your upload.php
- in your directory where you place the unzip, go to terraform folder cmd do "terraform apply" and yes. this will let terraform run.
- after it is completed it will give you de ip, put this in a browser and wait a few minutes and there will be your page.



Delete the cloud:
- go to your bucket go in the folder uploads and delete all the files you uploaded
- then in cmd place: terraform destroy
and then yes