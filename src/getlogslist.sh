readarray -t svc_arr <<< $(cat services.txt)
svcloop=0
pwd=$(pwd)

while [ true ]
do
    if [ ! -z "${svc_arr[$loop]}" ]; then

        export NS=$(echo ${svc_arr[$svcloop]} | tr -d '\r')

        if [ -z "$NS" ]
        then
            exit 0
        else
            echo "[Creating logs for namespace: $NS]"
            ./src/getlogs.sh "$NS"
        fi

        svcloop=$(( $svcloop + 1 ))
    else
        echo "[Operation ended.]"
        break
    fi
done