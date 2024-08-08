# https://atlasgo.io/getting-started
.PHONY: gen-atlas-schema
gen-atlas-schema:
	rm -rf schema.hcl
	atlas schema inspect -u "postgres://admin:admin@localhost/example?sslmode=disable" > schema.hcl
	# https://gh.atlasgo.cloud/explore
