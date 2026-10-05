# {{_lua: (function() local d = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h:t'); if d == '' then return vim.fn.input('target: ') end; return d end)() _}} (pivot)

start: {{_date_}}

# target

```
export via=""
export target="{{_cursor_}}"
export tun_ip=""

export user=""
export pass=""
```

# tunnel

| # | via | target | port | コマンド | 状態 |
| --- | --- | --- | --- | --- | --- |
| 1 |  |  |  |  |  |

# egress

- [ ] icmp
- [ ] http
- [ ] dns
- [ ] その他tcp
- [ ] tcpdumpで全トラフィック監視

```
sudo tcpdump -i tun0 -n 'not port 22'
```

# enum

```
nmap-auto $target
```

# main

# feeling

## 簡易チェックリスト

- [ ] ルート確認 (ip route / ping)
- [ ] コマンド出力の保存
- [ ] 取得したcredentialsを記録

## 観察

## 試したこと / 失敗経路

# 精算
