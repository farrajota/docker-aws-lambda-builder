# Build and package code with custom libraries to aws lambda

Build and package code using custom libraries into an aws lambda compatible zip file with little to no effort. Additionally, you can also upload the packaged code to S3 using a simple command.

## Requirements

- [Docker](https://www.docker.com/)
- [aws cli](https://pypi.org/project/awscli/) (optional)
- Dependencies listed in either `requirements.txt` or `Pipfile.lock` / `Pipfile`

## How to use

To build and package your code, all you need to do is to copy your code to the `code/` folder and run the following command:

```bash
$ make build-package
```

This will build and package your code targetting Python 3.7 as the run time into a `zip` file (`lambda.zip`).

If you wish to target another version for python, or to change the output name of the zip file, you can use the `version=` and `filename=` input arguments, respectively:

```bash
$ make build-package version=<version> filename=<file_name>
```

Also, if you want to target a different folder where your code is located, you can do this as well by specifying the target directory using `target_dir=</path/to/dir>`:

```bash
$ make build-package version=<version> filename=<file_name> target_dir=</path/to/dir/>
```

### Example

You want to build your code with Python 3.7 as a target, but you only have version 3.6 installed or you have been using Python 3.6 but want to package it using 3.7 with compatible libraries. Assuming you are using either a `requirements.txt` or a `Pipfile.lock` file to store the dependencies used in your code, to build and package your code painlessly, you need to do the following:

```bash
$ make build-package version=3.7 filename=example.zip target_dir=</home/code>
```

This will generate the aws lambda compatible zip file  `example.zip` containing  all the specified libraries in `requirements.txt` or `Pipfile.lock` built targeting Python 3.7 as the runtime. If you wish to use another version of Python, all you need to do is change the target version from 3.7 to the version you want in the `make build-package` macro.

# Uploading to S3

In order to upload the file to S3, it is required you to have a authentication configured for aws-cli using either a config file (`~/.aws/credentials`) or environment variables. If you are using environment variables, you can set an account in the command line with the following commands:

```bash
$ export AWS_ACCESS_KEY_ID=<access_key>
$ export AWS_SECRET_ACCESS_KEY=<secret_key>
```

Then, to upload the packaged file to S3, run the following command in the terminal:

```bash
$ make upload filename=<filename_zip> bucket=<bucket_name>
```

# License

[MIT](LICENSE)