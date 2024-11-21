homedir=$(pwd)

echo "[Current directory:] ${homedir}"

echo "[Checking for kubectl installation...]"
if ! [ -x "$(command -v kubectl)" ]; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
fi

echo "[Checking for envsubst installation...]"
if ! [ -x "$(command -v envsubst)" ]; then
    apt-get update
    apt-get --assume-yes install gettext-base
fi

echo "[Checking for zip installation...]"
if ! [ -x "$(command -v unzip)" ]; then
    apt-get update
    apt-get --assume-yes install zip
fi

echo "[Checking for AWS CLI installation...]"
if ! [ -x "$(command -v aws)" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
fi

echo "[Applying Kubeconfig...]"
if aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME} ; then KUBECONFIG=$(eval echo ~$USER)"/.kube/config" ; else echo ""; fi

echo "[Configuring namespace...]"
if ! kubectl get namespaces  | grep "${MICROSERVICE_NAME}-${ENVIRONMENT}" ; then kubectl create namespace ${MICROSERVICE_NAME}-${ENVIRONMENT} ; fi

#Listing files for visibility
echo "[Listing files...]"
ls
echo "[End of file listing]"

echo "[Creating namespace (if it does not exist)...]"
kubectl create namespace ${PROJECT_NAME}-${MICROSERVICE_NAME}-${ENVIRONMENT} --dry-run=server -o yaml | kubectl apply -f -

echo "[Deleting deployment]"
kubectl delete deployment ${MICROSERVICE_NAME} -n=${PROJECT_NAME}-${MICROSERVICE_NAME}-${ENVIRONMENT}


for f in  ${homedir}/manifests/*.yaml; 
    do 
    if [[ "$f" != "0" ]];then
        echo ""
        echo "[Applying file in kubectl: $f]"
        envsubst < $f | kubectl apply -f -
    fi  
    done

aws ecr put-image-scanning-configuration --repository-name ${MICROSERVICE_NAME}-${ENVIRONMENT} --image-scanning-configuration scanOnPush=true

kubectl rollout restart deployment -n ${PROJECT_NAME}-${MICROSERVICE_NAME}-${ENVIRONMENT}