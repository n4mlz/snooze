# Monitoring

監視基盤は開発・本番ともルート Compose で起動します。

## 開発

```sh
task setup
task dev
```

Grafana は `http://127.0.0.1:3001`、Alertmanager は `http://127.0.0.1:9093` で確認できます。開発・本番とも Discord Webhook へ通知します。

既存の `sns-backend/sql_data` を使う場合、`env/*/db.env` の MariaDB のパスワードは、データディレクトリを初期化したときの値と一致させてください。

## 本番

本番サーバーには Tailscale をあらかじめインストールしてログインし、`env/prod/infra.env` の Grafana 管理者パスワード/Discord Webhook URL と、`env/prod/mysqld-exporter.env` の監視用 DB ユーザー情報を設定してください。

`ALERTMANAGER_DISCORD_WEBHOOK_URL` は example のダミー値から、Discord のチャンネル Webhook URL に置き換えてください。

```sh
task deploy
```

`task deploy` は監視コンテナを含めて起動し、Grafana をホストの `127.0.0.1:3001` に bind したうえで Tailscale Serve に登録します。Grafana は公開ポートに bind されないため、Tailscale に接続した端末からのみアクセスできます。Tailscale Serve の状態は次で確認できます。

```sh
task monitoring:serve:status
```

Tailscale の認証情報はリポジトリや `env/prod` に保存しません。Tailscale Serve は Funnel ではなく Serve を使います。

## 収集対象

- backend: `/metrics`, `/healthz`, `/readyz`
- Prometheus、Traefik、node-exporter、cAdvisor
- MariaDB exporter
- frontend/backend の HTTP 外形監視
- Grafana の固定 datasource と overview dashboard
- Loki + Grafana Alloy によるコンテナログ
- Alertmanager の Discord 通知

本番で変更した Discord Webhook URL は、Alertmanager の再起動後に反映されます。
