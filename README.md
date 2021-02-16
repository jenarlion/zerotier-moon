This is based off of seedgou/zerotier-moon
it has been updated to work with the latest zerotier-containerized
modify startup.sh to work with newer standard

typical launch commands 

docker run --name zerotier-moon -v YOURSTORAGENAME:/var/lib/zerotier-one --cap-add=NET_ADMIN --cap-add=SYS_ADMIN -d -p 9993:9993/udp zerotier-moon:latest -4 IPV4ADDRESSHERE
