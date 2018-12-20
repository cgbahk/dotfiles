# check linux distribution
cat /etc/os-release

# docker rmi <none>s
docker rmi $(docker images -f "dangling=true" -q)

