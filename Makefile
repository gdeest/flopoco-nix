image:
	docker load -i `nix-build -A dockerImage`

push: image
  # Keep tag in sync with version in default.nix
	docker tag flopoco:4.1.2 gdeest/flopoco:4.1.2
	docker push gdeest/flopoco

.PHONY: image
