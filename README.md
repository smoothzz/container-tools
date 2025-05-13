# Container Tools
___
## Why?

This project aims to bring together the set of tools (most cli's) that I use in my daily work routine. Usually I would install all these tools with a script, but I wanted something that I could build and have all together no matter the environment I'm using, as container solve this problem. I thought why not.

___

## How to use

Start by cloning the repository

```
git clone git@github.com:smoothzz/container-tools.git
```

Now there is only a matter of building the image locally with your preferred container tool, in this case, I use podman, and pass it a name of your choice.

```
podman build -f Containerfile -t NAMEYOURIMAGEHERE:VERSION .
```

Now that you have build you image you can run it just by giving your container a name and passing the image, in my case I call this yoda

```
podman run -it -d --name yoda smoothzz/container-tools:1.0
```

And there you go. If you need to install something that is missing, but, don't want to lose the container right away, you can just do "doas apk add PACKAGE", and then later just include this package in the Containerfile to be installed into the container.

## ToDo

Will bring a makefile to make it easier for me.