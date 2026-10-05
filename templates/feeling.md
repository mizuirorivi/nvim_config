# {{_lua: (function() local d = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h:t'); if d == '' then return vim.fn.input('target: ') end; return d end)() _}}

start: {{_date_}}
status: in-progress

# prepare

```
mkdir -p /work/ && cd /work/
```

# target

```
export targets=""
export ip="{{_cursor_}}"
export in_ip=""
export tun_ip=""

export user=""
export pass=""

export host=""
export host_dc=""
export domain=""
export dc_ip=""
```

# creds

| 取得 | アカウント | パスワード | 出所 |
| --- | --- | --- | --- |
|  |  |  |  |

# flags

- [ ] user.txt
- [ ] root.txt

```
# user.txt
# root.txt
```

# enum
## nmap-auto

```
nmap-auto $ip
```

## searchsploit

```
find ./ | grep nmap | nmap-sploit -r
```

## nxc

```
color_keep "nxc smb $targets -u $user -p $pass" | grep -v "-"
color_keep "nxc winrm $targets -u $user -p $pass" | grep -v "-"
color_keep "nxc rdp $targets -u $user -p $pass" | grep -v "-"
color_keep "nxc ldap $targets -u $user -p $pass" | grep -v "-"
```

## web

```
whatweb -v http://$ip
feroxbuster -u http://$ip/ -o ferox.out
```

## mssql

```
nxc mssql $ip -u $user -p $pass
```

## bloodhound

```
rusthound-ce -d $domain -u "$user"@$domain -p $pass -i $ip -f $host_dc -n $ip -c All -z
bloodhound-python -d $domain -u $user -p $pass -ns $ip -dc $host_dc -c All --zip
```

## other

# main

# AD

- [ ] DAへの最短パス確認 (bloodhound)
- [ ] ACL / 特殊権限 (bloodyad)
- [ ] delegation (unconstrained / constrained / RBCD)
- [ ] kerberoast / asreproast
- [ ] GPP / GPO / LAPS / gMSA
- [ ] ローカルadmin (psexec / wmiexec / smbexec / evil-winrm)
- [ ] dcsync

# pivot

| # | via | target | port | コマンド |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

egress確認:
- [ ] icmp
- [ ] http
- [ ] dns
- [ ] その他tcp
- [ ] tcpdumpで全トラフィック監視

# feeling

## 簡易チェックリスト

- [ ] 時間管理
- [ ] フラグ取得 + 提出
- [ ] コマンド出力の保存
- [ ] 取得したcredentialsを # creds に記録
- [ ] ルート確認 (ip route)

## 観察

## 試したこと / 失敗経路

# 精算

かかった時間:
覚えておくべき点:
次回のTips:

# session log

| 時刻 | 出来事 |
| --- | --- |
|  |  |
