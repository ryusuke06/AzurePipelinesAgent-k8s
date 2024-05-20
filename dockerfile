# ベースイメージを指定
FROM mcr.microsoft.com/azure-cli

# 必要なパッケージのインストール
RUN apt-get update -qqy && \
    apt-get install -qqy liblttng-ust0 libkrb5-3 zlib1g libicu[0-9][0-9] libcurl4 curl jq && \
    apt-get upgrade -qqy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Azure Pipelines Agentのインストール
RUN mkdir /agent
WORKDIR /agent
RUN curl -o agent.tar.gz -L https://vstsagentpackage.azureedge.net/agent/3.239.1/vsts-agent-linux-x64-3.239.1.tar.gz &&
RUN tar zxvf agent.tar.gz

# スクリプトをコピー
COPY start.sh .

# スクリプトに実行権限を付与
RUN chmod +x start.sh

# エージェントを起動
CMD ["./start.sh"]
