## Getting started

**To quickly try out penrose you can pull the docker image without needing to compile the code:**

1. Install [docker](https://www.docker.com/products/docker-desktop)
2. Run the following command:
   ```sh
   docker run -it -p 8000:8000 -p 9160:9160 dandavison7/penrose
   ```
3. Visit http://localhost:8000/client.html in a web browser and click on "Autostep".


To make the following commands more convenient let's rename the local docker image:
```
docker tag dandavison7/penrose penrose
```

**The docker image has several other linear algebra examples:**

For example:
```
docker run -it -p 8000:8000 -p 9160:9160 penrose \
    src/linear-algebra-domain/determinants.sub \
    src/linear-algebra-domain/linear-algebra.sty \
    src/linear-algebra-domain/linear-algebra.dsl
```

Look in the
[src/linear-algebra-domain/](https://github.com/penrose/penrose/tree/master/src/linear-algebra-domain)
directory for more examples.


## Running your own `.sub`, `.sty`, and `.dsl` files

To run your own `.sub`, `.sty`, and `.dsl` files you need to supply a few more arguments to mount your home directory inside the docker container:

```
docker run -it -p 8000:8000 -p 9160:9160 --volume=$HOME/:$HOME/ --workdir $PWD penrose \
    /path/to/my.sub \
    /path/to/my.sty \
    /path/to/my.dsl
```

To make this more convenient there's a shell script `docker/bin/penrose` in the git repository.


## For Penrose developers:

To build the image:
```
cd docker
make build
```
Issuing `make build` again after modifying the code in `src/` will trigger re-compilation of the `penrose` executable but not of the Haskell dependencies.
