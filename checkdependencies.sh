sudo apt update

echo "[Checking for dependencies"]

if command -v jq >/dev/null 2>&1 ; then
    echo "[jq found]"
    echo "version: $(nodejs -v)"
else
    echo "[jq not found]"
    echo "[Installing dependency]"
    sudo apt install jq
fi

if command -v kubectl >/dev/null 2>&1 ; then
    echo "[kubectl found]"
    echo "version: $(kubectl version --client)"
else
    echo "[kubectl not found]"
    echo "[Installing dependency]"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

if command -v aws >/dev/null 2>&1 ; then
    echo "[aws cli found]"
    echo "version: $(aws --version)"
else
    echo "[aws cli not found]"
    echo "[Installing dependency]"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
fi