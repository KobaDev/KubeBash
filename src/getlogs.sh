export output=$(kubectl get pods -n $1 --no-headers -o custom-columns=":metadata.name")

[ -z "$output" ] && echo "[No pods were found in the namespace.] $1" && exit 0

readarray -t pods <<< "$output"
logs_dir="$(pwd)/service_logs"

if [ -d "${logs_dir}/$1" ]; then
    rm "${logs_dir}/$1/"*/*
    rmdir "${logs_dir}/$1/"*
else
    mkdir -p "${logs_dir}/$1"
fi

for p in "${pods[@]}";
do
    mkdir -p "${logs_dir}/$1/$p"
    readarray -t containers <<< $(kubectl get pods $p -n $1 -o jsonpath="{.spec['containers','initContainers'][*].name}")
    for c in "${containers[@]}";
    do
        echo "[Creating logs for pod...] $p $c"
        kubectl logs $p -n $1 -c $c> "${logs_dir}/$1/$p/$c.log"
    done
done

echo "[Operation ended.]"

