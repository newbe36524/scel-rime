# 搜狗输入法词库转换为 RIME 词库

这是一个自动下载搜狗输入法的[细胞词库](http://pinyin.sogou.com/dict/)并转换为 `RIME` 词库的脚本。

## 必要准备 

- `python3`
- `bash`
- `curl`
- `yq`

<details>
<summary>Linux 安装脚本</summary>

```bash
# For Debian/Ubuntu
sudo apt update
sudo apt install -y python3 bash curl yq

# For Red Hat/CentOS
sudo yum install -y python3 bash curl yq

# For Fedora
sudo dnf install -y python3 bash curl yq
```

</details>

## 开始生成

### 搜索需要的词库

通过 <https://pinyin.sogou.com/dict/> 搜索需要的词库, 记下你需要的词库的 url，比如

计算机词汇大全【官方推荐】

https://pinyin.sogou.com/dict/detail/index/15117

### 修改配置

将你需要的词库连接和名称配置到 config.yml 中

```yaml
rime:
  urls:
    "计算机词汇大全【官方推荐】": https://pinyin.sogou.com/dict/detail/index/15117
    "日剧、动漫大全【官方推荐】": https://pinyin.sogou.com/dict/detail/index/20656
    "开发大神专用词库【官方推荐】": https://pinyin.sogou.com/dict/detail/index/15118
```

根据你目前安装的 rime 版本，修改 out。例如 fcitx5

```yaml
rime:
  out:
    fcitx5: "$HOME/.local/share/fcitx5/rime/cn_dicts"
    # fcitx: "$HOME/.local/share/fcitx/rime/cn_dicts"
    # ibus: "$HOME/.local/share/ibus/rime/cn_dicts"
```

### 运行脚本

```bash
./run.sh
```
运行成功的话，你就会看到

```bash
Config file config generated successfully
Fetching 15117: 计算机词汇大全【官方推荐】
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  354k  100  354k    0     0   777k      0 --:--:-- --:--:-- --:--:--  777k
------------------------------------------------------------
Fetching 20656: 日剧、动漫大全【官方推荐】
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  527k  100  527k    0     0   453k      0  0:00:01  0:00:01 --:--:--  453k
------------------------------------------------------------
Fetching 15118: 开发大神专用词库【官方推荐】
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  254k  100  254k    0     0   644k      0 --:--:-- --:--:-- --:--:--  643k
------------------------------------------------------------
Fetching 36423: 程序猿词库
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 27388  100 27388    0     0    99k      0 --:--:-- --:--:-- --:--:--   99k
------------------------------------------------------------
Fetching 50019: 编程语言
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 10636  100 10636    0     0  85420      0 --:--:-- --:--:-- --:--:-- 85774
------------------------------------------------------------