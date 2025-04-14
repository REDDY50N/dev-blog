Clone Image

```sh
# Clone remotely
ssh root@192.168.170.10 "dd if=/dev/sdb | gzip -1 -" | dd of=sdb_system.gz

```

