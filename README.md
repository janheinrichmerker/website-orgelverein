[![CI](https://img.shields.io/github/workflow/status/orgelverein/website/CI?style=flat-square)](https://github.com/orgelverein/website/actions?query=workflow%3ACI)
[![Issues](https://img.shields.io/github/issues/orgelverein/website?style=flat-square)](https://github.com/orgelverein/website/issues)

# Orgelverein am Braunschweiger Dom e.V. website

The _Orgelbauverein am Braunschweiger Dom e.V._ set itself the goal, to fund the choir organ for the _Braunschweiger Dom_.

## Intstallation

1. Install [Hugo](https://gohugo.io/) and [Yarn](https://yarnpkg.com/).
1. Install asset dependencies:

    ```shell script
    yarn --cwd assets
    ```

1. Run development server locally:

    ```shell script
    hugo server
    ```

    The website is now accessible at [http://localhost:1313](http://localhost:1313).

1. Build static website:

    ```shell script
    hugo
    ```

    You'll then find the static website in the `public` directory, ready to be deployed on any static web server.


## License

This repository is [not licensed](https://choosealicense.com/no-permission/), meaning you have to ask for permission if you want to use our code and/or content.
