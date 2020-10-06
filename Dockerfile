# Base image used is Microsoft provided image, this will be changed by alpine to create image which contain multiple netcore sdk
FROM mcr.microsoft.com/dotnet/sdk:5.0
MAINTAINER Valentin LECERF <valentin.lecerf@vlecerf.com>
# We do an update and we install java8 required for SQ Analysis
RUN apt-get update \
&& apt-get -y install default-jre
#Install node
ENV NODE_VERSION 12.19.0
ENV NODE_DOWNLOAD_SHA 6c35b85a7cd4188ab7578354277b2b2ca43eacc864a2a16b3669753ec2369d52

RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && node -v

#Install libs
RUN apt-get update -y && \
     apt-get install -y sqlite3 libsqlite3-dev build-essential libssl-dev libffi-dev python-dev ssh sshpass
RUN apt-get purge -y --auto-remove 

#Install TypeScript
RUN npm install -g typescript

#Install sonar scanner as global tool
RUN dotnet tool install --global dotnet-sonarscanner

#We add sonarscanner global tool to the path
ENV PATH "$PATH:/root/.dotnet/tools"

#We add typescript to the node PATH
ENV NODE_PATH "/usr/lib/node_modules/:/usr/local/bin/tsc:/usr/local/bin/tsserver"
