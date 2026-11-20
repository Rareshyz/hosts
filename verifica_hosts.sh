#!/bin/bash
verifica_ip() {
    local host="$1"
    local ip="$2"
    local dns="$3"
    local rezolvat

    rezolvat=$(dig +short @"$dns" "$host" A)

    if echo "$rezolvat" | grep -qx "$ip"; then
        echo "OK: $host -> $ip"
    else
        echo "EROARE: $host nu corespunde cu $ip (DNS a răspuns: $rezolvat)"
    fi
}
grep -vE '^\s*(#|$)' /etc/hosts | while read -r ip host _; do
    verifica_ip "$host" "$ip" 8.8.8.8
done
