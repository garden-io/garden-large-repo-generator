#!/usr/bin/env sh

set -e

cd spring-boot/deployment/pulumi
echo "Creating large number of files..."
for i in {1..1000}; do
  echo $i
  cp "package-lock.json" "dummy-file-${i}"
done

cd ../../..
echo "Creating large number of spring-boot module copies..."
for i in {1..100}; do
  echo $i
  cp -R spring-boot "spring-boot-${i}"
  yq -i '.name = "spring-boot-'$i'"' spring-boot-$i/spring-boot.garden.yml
done
