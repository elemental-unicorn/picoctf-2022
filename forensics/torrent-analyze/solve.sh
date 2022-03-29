#!/bin/bash


hashes="$(tshark -r torrent.pcap -Y 'bt-dht.bencoded.string=="info_hash"' -Tjson -e 'bt-dht.bencoded.string' \
	| jq '.[] | ._source.layers' \
	| grep info_hash -A1 \
	| awk '{print $1}' \
	| sort \
	| uniq \
	| sed -E 's/"?(.{40})"?,?/\1/g' \
	| grep -E '.{40}' \
	| tr '\n' ' ')"

echo "${hashes}"

for h in ${hashes}; do
	curl -sSL "https://linuxtracker.org/index.php?page=torrent-details&id=${h}" \
		| grep '.iso'
done
