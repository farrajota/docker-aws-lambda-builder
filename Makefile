filename=lambda.zip
version=3.7
build-package:  # build and package the code to a zip file
	docker run \
		--rm \
		-w /home \
		-v $(PWD):/home \
		--name aws_lambda_builder \
		lambci/lambda:build-python$(version) \
		bash build.sh $(filename)

upload:  # upload file to s3
	aws s3 cp $(filename) s3://$(bucket_name)/$(filename)
