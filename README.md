### Build docker image
`docker build -t my-lua .`

### Start docker container
`docker run -dti -v "$(pwd)/source-code:/var/source-code" -p 8080:8080 my-lua`
