FROM neo-cli:latest

ARG ir_git
ARG ir_ver

WORKDIR /
# Build ir
RUN git clone ${ir_git}
WORKDIR /neo-plugins
RUN git checkout ${ir_ver}
WORKDIR /neo-plugins/src/FileStorageIR
RUN dotnet publish -o publish
RUN cp -rf publish/FileStorageIR publish/FileStorageIR.dll /neo-cli/Plugins/
RUN cp -rf publish/CsvHelper.dll \
  publish/FileStorageBase.dll \
  publish/Google.Protobuf.dll \
  publish/Grpc*.dll \
  publish/Multiformats*.dll \
  publish/NetTopologySuite*.dll \
  publish/Sprache.dll \
  publish/Neo.FileStorage.API.dll \
  publish/ZstdNet.dll \
  publish/Resources \
  /neo-cli/
WORKDIR /
RUN rm -rf /neo-plugins
WORKDIR /neo-cli/
CMD [ "./neo-cli"]
