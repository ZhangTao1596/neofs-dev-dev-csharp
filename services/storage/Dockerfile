FROM neo-cli:latest

ARG storage_git
ARG storage_ver

RUN apt-get update & apt-get install -y libzstd-dev

WORKDIR /
# Build storage
RUN git clone ${storage_git}
WORKDIR /neo-plugins
RUN git checkout ${storage_ver}
WORKDIR /neo-plugins/src/FileStorageST
RUN dotnet publish -o publish
RUN cp -rf publish/FileStorageST publish/FileStorageST.dll /neo-cli/Plugins/
RUN cp publish/FileStorageBase.dll \
  publish/Google.Protobuf.dll \
  publish/Grpc*.dll \
  publish/Multiformats*.dll \
  publish/Sprache.dll \
  publish/Neo.FileStorage.API.dll \
  publish/ZstdNet.dll \
  /neo-cli/
WORKDIR /
RUN rm -rf /neo-plugins
WORKDIR /neo-cli/
CMD [ "./neo-cli"]
