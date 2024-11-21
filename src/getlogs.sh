export output=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" -n $1)

if [ -z "$output" ]; then
    echo "[No pods were found in the namespace]".
else
    readarray -t arr <<< "$output"
    loop=0
    pwd=$(pwd)

    if [ ! -d "$pwd/service_logs/$1" ]; then
        mkdir -p "$pwd/service_logs/$1"
    else
        rm "$pwd"/service_logs/$1/*
    fi

    while [ true ]
    do
        if [ ! -z "${arr[$loop]}" ]; then
            echo "[Creating logs for pod...] ${arr[$loop]}"
            kubectl logs ${arr[$loop]} -n $1 > "$pwd/service_logs/$1/${arr[$loop]}.log"
            loop=$(( $loop + 1 ))
        else
            echo "[Operation ended.]"
            break
        fi
    done
fi