# TraceAI 部署说明

## 日常使用（推荐 · 隐私）

```bash
cd traceai
python3 -m http.server 8080
```

在浏览器打开 `http://localhost:8080`。个人对话与备份**不要**提交到 Git。

公开仓库 / Pages 只托管：**index.html、showcase.html、sample/**（无个人数据）。

---

## 部署到 GitHub Pages（仅 Demo 壳）

## 方式 A：一键脚本（推荐）

```bash
cd /Users/Shared/traceai
chmod +x scripts/push-to-github.sh
./scripts/push-to-github.sh traceai
```

需要已安装 [GitHub CLI](https://cli.github.com/) 并执行过 `gh auth login`。

## 方式 B：Cursor GitHub MCP

在 Cursor → Settings → MCP → **user-github** 配置有效的 Personal Access Token（勾选 `repo` 权限），保存后让 Agent 执行 `create_repository` + `push_files`。

若出现 `Authentication Failed: Bad credentials`，请重新生成 Token 并更新 MCP 配置。

## 方式 C：手动

### 1. 创建仓库

1. 打开 https://github.com/new
2. Repository name：**`traceai`**
3. Public → Create repository（不要勾选 README）

## 2. 推送代码

在终端执行（路径按你的机器调整）：

```bash
cd /Users/Shared/traceai
git init -b main
git add -A
git commit -m "feat: TraceAI MVP — Claude JSON to knowledge map"
git remote add origin https://github.com/<你的用户名>/traceai.git
git push -u origin main
```

## 3. 开启 Pages

1. 仓库 **Settings → Pages**
2. **Build and deployment → Source**：Deploy from a branch
3. Branch：**main** / **/ (root)**
4. Save

约 1–2 分钟后访问：`https://<你的用户名>.github.io/traceai/`

## 4. 验证清单

- [ ] 点击「加载示例 Demo」能看到图谱
- [ ] 五个 Tab 可切换
- [ ] 修改状态后刷新页面仍保留
- [ ] 「导出 Obsidian 包」能下载 ZIP
