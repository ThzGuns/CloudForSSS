Steps for cloud:

- install terrafrom
- install aws cli
- create a user with acces to s3 and ec2
- create a folder and run: git init 
- after that pull the git with: git remote add Cloud https://github.com/ThzGuns/CloudForSSS.git 
- then run in the folder: git pull Cloud master
- also create a pairkey for your ec2, then go to variables.tf and change where
  this stands next to #<-- change key to your key name
- in your cmd run: terraform init
- then: terraform apply
- after that it ask for yes
- after it is completed it will give you de ip, put this in a browser and wait a few minutes
  and there will be your page.



Delete the cloud:
- go to your bucket go in the folder uploads and delete all the files you uploaded
- then in cmd place: terraform destroy
and then yes



