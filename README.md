# go-release-sample

This repository is sample code for automatic release in Go applications.
After modifying the application, by following the steps below, binaries will be automatically generated for each environment via GitHub Actions.

## 1. How to bump up app version as semantic versioning

### bump up major version 
```
make major-version
```

### bump up minor version
```
make minor-version
```

### bump up patch version
```
make patch-version
```

After running these commands, the version variable in main.go will be overwritten.

## 2. Pushing commits and tags after rewriting the version

First, commit main.go with new version.
```
git add .
```

Then, commit your changes, create the tag, and push with one of the commands below.

```
make push-tag
```

or 

```
git commit -m "Update: v$(make app-version)"
git tag v$(make app-version)
git push origin v$(make app-version)
```

## 3. Checking GitHub actions to make package

1. Go to the GitHub Actions page and check that the expected version of the Action finishes successfully.
<img width="1838" alt="github-actions" src="https://github.com/iselegant/go-release-sample/assets/30573608/75fc1119-e402-4b71-92d2-9f30e8125abc">


2. Go to the repository's main page and make sure the Release is updated. In this example "refs/tags/v1.0.7" is released.
<img width="1322" alt="release-1" src="https://github.com/iselegant/go-release-sample/assets/30573608/4b2cb850-88f9-44e8-accd-dead1e431de8">


3. Make sure you can get the built binaries.
<img width="1837" alt="release-2" src="https://github.com/iselegant/go-release-sample/assets/30573608/808cde54-1304-4287-8309-d2423be7850e">
