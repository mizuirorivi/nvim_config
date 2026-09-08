# {{_lua: (function() local d = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h:t'); if d == '' then return vim.fn.input('lab: ') end; return d end)() _}} (lab)

start: {{_date_}}

# prepare

```
mkdir -p /work/ && cd /work/
```

# target

```
export targets="{{_cursor_}}"
export in_targets=""

export ip01=""
export ip02=""
export ip03=""
export ip04=""
export ip05=""
export ip06=""
export ip07=""
export ip08=""
export ip09=""

export in_ip01=""
export in_ip02=""
export in_ip03=""

export tun_ip01=""
export tun_ip02=""
export tun_ip03=""
export tun_ip04=""
export tun_ip05=""
export tun_ip06=""
export tun_ip07=""
export tun_ip08=""
export tun_ip09=""

export user=""
export pass=""

export host_dc=""
export domain=""
export dc_ip=""
```

# progress

| VM | IP | OS | user flag | root flag | 状態 | 所要時間 |
| --- | --- | --- | --- | --- | --- | --- |
| ip01 |  |  |  |  |  |  |
| ip02 |  |  |  |  |  |  |
| ip03 |  |  |  |  |  |  |
| ip04 |  |  |  |  |  |  |
| ip05 |  |  |  |  |  |  |
| ip06 |  |  |  |  |  |  |
| ip07 |  |  |  |  |  |  |
| ip08 |  |  |  |  |  |  |
| ip09 |  |  |  |  |  |  |

# creds

| 取得 | アカウント | パスワード | 出所 |
| --- | --- | --- | --- |
|  |  |  |  |

# topology

# enum

```
nmap -sn $targets | awk '/Nmap scan report/{print $NF}' | tr -d '()'
nxc smb $targets --generate-hosts-file hosts
cat hosts | sudo tee -a /etc/hosts
```

# main

# feeling

## 簡易チェックリスト

- [ ] 時間管理 (24h)
- [ ] フラグ取得 + 提出
- [ ] コマンド出力の保存
- [ ] 取得したcredentialsを # creds に記録
- [ ] ルート確認 (ip route)

## 観察

## 試したこと / 失敗経路

# 精算

# session log

| 時刻 | 出来事 |
| --- | --- |
|  |  |
