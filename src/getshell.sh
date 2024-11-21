export output=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" -n $1)

if [ -z "$output" ]; then
    echo "[No pods were found in the namespace]".
else
    readarray -t arr <<< "$output"
    echo "[Starting Bash session in pod ${arr[$loop]} at namespace $1]".
    kubectl exec --stdin --tty -n $1 ${arr[$loop]} -- /bin/bash
fi