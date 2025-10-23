#!/bin/sh
set -e

scope=${NPM_PACKAGE_SCOPE:-""}
name=$(npm pkg get name | tr -d '"') 
version=$(npm pkg get version | tr -d '"')
tag=${NPM_PUBLISH_TAG:-dev}

if [ "$scope" != "" ]; then
    name="${scope}/${name}"
fi

if [ "$tag" = "dev" ]; then
    version="${version}-dev.$(git rev-parse --short HEAD)"
fi

cp package.json package.json.bak
npm ci
npm run build
npm pkg set version="${version}"
npm pkg set name="${name}"
npm pkg delete scripts.prepare

if [ -z "$DRY_RUN" ]; then
    npm publish --tag "${tag}" --access public
else
    npm publish --tag "${tag}" --access public --dry-run
fi

mv package.json.bak package.json