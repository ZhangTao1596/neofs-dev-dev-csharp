FROM mcr.microsoft.com/dotnet/sdk:5.0

ARG node_git
ARG node_ver
ARG modules_git
ARG modules_ver

RUN apt-get update && apt-get install -y \
  expect \
  screen \
  unzip \
  git \
  libleveldb-dev
WORKDIR /

# neo-cli
RUN git clone ${node_git}
WORKDIR /neo-node
RUN git checkout ${node_ver}
WORKDIR /neo-node/neo-cli/
RUN mkdir /neo-cli
RUN dotnet publish --self-contained  -r linux-x64 -o /neo-cli

# neo-modules
RUN mkdir /neo-cli/Plugins
WORKDIR /
RUN git clone ${modules_git}
WORKDIR /neo-modules
RUN git checkout ${modules_ver}
# LeveDB
WORKDIR /neo-modules/src/LevelDBStore
RUN dotnet publish -o publish
RUN cp publish/LevelDBStore.dll /neo-cli/Plugins/
# DBFT
WORKDIR /neo-modules/src/DBFTPlugin
RUN dotnet publish -o publish
RUN cp -rf publish/DBFTPlugin.dll publish/DBFTPlugin /neo-cli/Plugins/

# clean
WORKDIR /
RUN rm -rf neo-node neo-modules
WORKDIR /neo-cli
CMD [ "./neo-cli" ]
