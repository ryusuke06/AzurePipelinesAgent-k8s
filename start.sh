#!/bin/bash

# Azure DevOpsのパラメータを環境変数から取得
AZP_URL=${AZP_URL}
AZP_TOKEN=${AZP_TOKEN}
AZP_POOL=${AZP_POOL}
AZP_AGENT_NAME=${AZP_AGENT_NAME:-$(hostname)}

# Azure DevOpsエージェントの設定
./config.sh --unattended --url $AZP_URL --auth pat --token $AZP_TOKEN --pool $AZP_POOL --agent $AZP_AGENT_NAME

# エージェントの起動
./svc.sh install
./svc.sh start

# 無限ループでコンテナが終了しないようにする
while true; do
    sleep 1000
done

