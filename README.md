# GitMA-docker

Create a docker image, based on [conda-forge](https://conda-forge.org) and push it to docker hub. Get the image with:

```
docker pull gerstorfer/gitma-demo:latest
```

And run with: 

```
docker run -it --publish 8888:8888 --name gitma-demo gerstorfer/gitma-demo:latest 
```

![screenshot](screenshot.png)

To start the container again later, use:

```
docker start -ai gitma-demo
```
