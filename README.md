Generation script based off of seedgou/zerotier-moon
Image uses a Debian-slim base and installs ZeroTier using their build script.

Updated May 2, 2022 - 1.8.9

# docker-zerotier-moon
Create a container zerotier-moon in a single stage.

### Important Notes

You MUST have a static ip to work with, until ZT 2.0 comes out there is NO dynamic capabilities
if your ip changes all clients will need to deorbit and reorbit.

When creating the container for the first time it will go through a generation period
the moon ID will not be persistent unless you use storage!

This should support x86_64, x86, arm, and arm64 but only x86_64 has been tested.

## Usage

### Pull the image

```
docker pull stevo11811/zerotier-moon
```

### Start a container

```
docker run --name zerotier-moon -d -p 9993:9993/udp -v YourStorageHere:/var/lib/zerotier-one stevo11811/zerotier-moon -4 1.2.3.4 -6 2001:abcd:abcd::1
```

This image supports both IPv4 and IPv6

### Checking logs (mainly to get ID)

```
docker logs zerotier-moon
```

### Manage ZeroTier

```
docker exec zerotier-moon /zerotier-cli
```

### IPv6 support

```
docker run --name zerotier-moon -d -p 9993:9993/udp stevo11811/zerotier-moon -4 1.2.3.4 -6 2001:abcd:abcd::1
```

Replace `1.2.3.4`, `2001:abcd:abcd::1` with your moon's IP. You can remove `-4` option in pure IPv6 environment.

### Custom port

```
docker run --name zerotier-moon -d -p 9994:9993/udp stevo11811/zerotier-moon -4 1.2.3.4 -p 9994
```

Replace 9994 with your own custom port for ZeroTier moon.

### Special Note for CentOS

NET_ADMIN and SYS_ADMIN may be required.

```
docker run --name zerotier-moon -v YourStorageHere:/var/lib/zerotier-one --cap-add=NET_ADMIN --cap-add=SYS_ADMIN -d -p 9993:9993/udp stevo11811/zerotier-moon -4 1.2.3.4
```
