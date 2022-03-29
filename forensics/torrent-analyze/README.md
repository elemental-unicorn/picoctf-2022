# Torrent Analyze

## Description

_--missing--_

## Solve
Reading the link provided we can see tha the `info_hash` value in the `bt-dht` packets is going to be unique per torrent.

From that information you can pull each of these fields with tshark and output as json

```bash
tshark -r torrent.pcap -Y 'bt-dht.bencoded.string=="info_hash"' -Tjson -e 'bt-dht.bencoded.string' > output.json
```

We can then use some bash tools to clean up the output

```bash
cat output.json \
    | jq '.[] | ._source.layers' \
	| grep info_hash -A1 \
	| awk '{print $1}' \
	| sort \
	| uniq \
	| sed -E 's/"?(.{40})"?,?/\1/g' \
	| grep -E '.{40}' \
	| tr '\n' ' ')"
```

Following this we can manually search each hash in google to find reference to hash `e2467cbf021192c241367b892230dc1e05c0580e` on [linuxtracker.org](https://linuxtracker.org/index.php?page=torrent-details&id=e2467cbf021192c241367b892230dc1e05c0580e).

_Note: the `solve.py` script in this folder can automate the discovery._

## Flag
`picoCTF{ubuntu-19.10-desktop-amd64.iso}`