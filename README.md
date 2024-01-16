## Headless subsystem
This system is used for emergency or init of the module

### How to use it:

- Windows:

In order to use it in PowerShell by the PS script you should enable script execution first:

> Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

after that you can execute the PS script:

- To build the image:
> .\docker\headless\docker-compose.ps1 -Action "build" -Option "--no-cache"

- To start the container:
> .\docker\headless\docker-compose.ps1 -Action "up" -Option "-d"

- To stop the container:
> .\docker\headless\docker-compose.ps1 -Action "down" 

- Linux

In order to use it on linux, there is any particular prescription, just run:

- To build the image:
> ./docker/headless/docker-compose.sh build --no-cache

- To start the container:
> ./docker/headless/docker-compose.sh up -d

- To stop the container:
> ./docker/headless/docker-compose.sh down

