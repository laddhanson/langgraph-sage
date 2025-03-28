FROM langchain/langgraphjs-api:20



ADD . /deps/langgraph-sage

RUN cd /deps/langgraph-sage && yarn install --frozen-lockfile

ENV LANGSERVE_GRAPHS='{"agent": "./src/agent/graph.ts:graph"}'


WORKDIR /deps/langgraph-sage

RUN (test ! -f /api/langgraph_api/js/build.mts && echo "Prebuild script not found, skipping") || tsx /api/langgraph_api/js/build.mts