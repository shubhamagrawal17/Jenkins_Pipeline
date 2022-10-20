az login
##########Create a resource group###########
az group create --name Test1 --location eastus
######Create a container registry##########################
az acr create --resource-group Test1 --name demo76453 --sku Basic
###############Log in to registry###############
az acr login --name demo76453
###############Pull Image locally and Tag it ###############
docker pull mcr.microsoft.com/hello-world
docker tag mcr.microsoft.com/hello-world demo76453.azurecr.io/hello-world:v1
#####Push image to registry###########
docker push demo76453.azurecr.io/hello-world:v1
######List container images ############
az acr repository list --name <registry-name> --output table