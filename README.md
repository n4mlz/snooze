# snooze

```sh
task setup
task dev
```

本番サーバーでは `env/prod/*.env` と `sns-backend/serviceAccountKey.json` を用意してから、次を実行します。

```sh
task deploy
```

CI が GHCR に公開した frontend/backend イメージを pull して起動します。

CI には frontend の `NEXT_PUBLIC_*` を Repository Variables として登録します。

監視基盤の構成・Tailscale の初回設定は [docs/monitoring.md](docs/monitoring.md) を参照してください。
