# Base image used is Microsoft provided image, this will be changed by alpine to create image which contain multiple netcore sdk
FROM microsoft/dotnet:2.2-sdk
# We do an update and we install java8 required for SQ Analysis
RUN apt-get update \
&& apt-get install default-jre
