docker build --tag devops-candidate .
docker run --detach --publish 8000:8000 devops-candidate
docker ps --all
#aws ecr create-repository --repository-name devops-candidate --region eu-west-1
docker tag devops-candidate 051206567486.dkr.ecr.eu-west-1.amazonaws.com/devops-candidate
#aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 051206567486.dkr.ecr.eu-west-1.amazonaws.com
#docker push 051206567486.dkr.ecr.eu-west-1.amazonaws.com/devops-candidate
#aws ecr delete-repository --repository-name devops-candidate --region eu-west-1 --force
