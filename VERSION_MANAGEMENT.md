# 版本管理指南

## 🏷️ Git Tag 操作

### 1. 创建 Tag

#### 轻量级 Tag（简单标记）
```bash
# 为当前提交创建 tag
git tag v1.0.0

# 为指定提交创建 tag
git tag v1.0.0 <commit-hash>
```

#### 附注 Tag（推荐，包含详细信息）
```bash
# 创建带注释的 tag
git tag -a v1.0.0 -m "发布版本 1.0.0

功能特性：
- 实现基础录制功能
- 添加悬浮按钮控制
- 支持自动下载
- 包含隐私保护"

# 为指定提交创建附注 tag
git tag -a v1.0.0 <commit-hash> -m "版本说明"
```

### 2. 推送 Tag

```bash
# 推送单个 tag
git push origin v1.0.0

# 推送所有 tag
git push origin --tags

# 推送代码和 tag（推荐）
git push origin main --tags
```

### 3. 查看 Tag

```bash
# 列出所有 tag
git tag

# 列出匹配模式的 tag
git tag -l "v1.*"

# 查看 tag 详细信息
git show v1.0.0

# 查看 tag 对应的提交
git log --oneline --decorate --graph
```

### 4. 删除 Tag

```bash
# 删除本地 tag
git tag -d v1.0.0

# 删除远程 tag
git push origin --delete v1.0.0

# 或者使用这种方式删除远程 tag
git push origin :refs/tags/v1.0.0
```

## 📋 版本发布完整流程

### Step 1: 准备发布
```bash
# 确保在 main 分支
git checkout main

# 拉取最新代码
git pull origin main

# 检查工作区是否干净
git status
```

### Step 2: 更新版本号
```bash
# 编辑脚本文件，更新 @version
# 例如：// @version 1.0.0 -> // @version 1.0.1
```

### Step 3: 提交版本更新
```bash
# 添加修改的文件
git add rrweb-recorder.user.js package.json

# 提交版本更新
git commit -m "chore: 发布版本 1.0.1

- 修复录制按钮显示问题
- 优化错误提示信息
- 更新依赖库版本"
```

### Step 4: 创建 Tag
```bash
# 创建附注 tag
git tag -a v1.0.1 -m "版本 1.0.1

修复内容：
- 修复录制按钮在某些网站不显示的问题
- 优化错误提示信息的显示效果
- 更新 rrweb 依赖库到最新版本

兼容性：
- 支持 Chrome 60+
- 支持 Firefox 55+
- 支持 Safari 12+"
```

### Step 5: 推送到远程
```bash
# 推送代码和 tag
git push origin main --tags
```

### Step 6: 创建 GitHub Release
```bash
# 使用 GitHub CLI（可选）
gh release create v1.0.1 \
  --title "RRWeb 录制工具 v1.0.1" \
  --notes "修复录制按钮显示问题，优化用户体验" \
  rrweb-recorder.user.js
```

## 🔄 版本号规范

### 语义化版本控制 (SemVer)

格式：`MAJOR.MINOR.PATCH`

- **MAJOR** (主版本号): 不兼容的 API 修改
- **MINOR** (次版本号): 向下兼容的功能性新增
- **PATCH** (修订版本号): 向下兼容的问题修正

### 版本号示例

```
1.0.0 - 首次发布
1.0.1 - 修复 bug
1.0.2 - 修复另一个 bug
1.1.0 - 添加新功能（向下兼容）
1.1.1 - 修复新功能的 bug
2.0.0 - 重大更新（可能不兼容）
```

### 预发布版本

```
1.1.0-alpha.1 - Alpha 测试版
1.1.0-beta.1  - Beta 测试版
1.1.0-rc.1    - Release Candidate
```

## 🚀 自动化发布脚本

创建一个自动化发布脚本：

```bash
#!/bin/bash
# release.sh - 自动化发布脚本

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 开始发布流程${NC}"

# 检查是否在 main 分支
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo -e "${RED}❌ 请在 main 分支执行发布${NC}"
    exit 1
fi

# 检查工作区是否干净
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${RED}❌ 工作区不干净，请先提交所有修改${NC}"
    exit 1
fi

# 拉取最新代码
echo -e "${YELLOW}📥 拉取最新代码...${NC}"
git pull origin main

# 获取当前版本
current_version=$(grep "@version" rrweb-recorder.user.js | sed 's/.*@version[[:space:]]*//')
echo -e "${YELLOW}📋 当前版本: ${current_version}${NC}"

# 输入新版本号
read -p "请输入新版本号 (如 1.0.1): " new_version

# 验证版本号格式
if ! [[ $new_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}❌ 版本号格式错误，请使用 x.y.z 格式${NC}"
    exit 1
fi

# 更新脚本中的版本号
echo -e "${YELLOW}📝 更新版本号...${NC}"
sed -i.bak "s/@version.*/@version      $new_version/" rrweb-recorder.user.js
rm rrweb-recorder.user.js.bak

# 更新 package.json 中的版本号
sed -i.bak "s/\"version\": \".*\"/\"version\": \"$new_version\"/" package.json
rm package.json.bak

# 输入更新说明
echo "请输入本次更新的说明 (按 Ctrl+D 结束输入):"
update_notes=$(cat)

# 提交版本更新
echo -e "${YELLOW}💾 提交版本更新...${NC}"
git add rrweb-recorder.user.js package.json
git commit -m "chore: 发布版本 $new_version

$update_notes"

# 创建 tag
echo -e "${YELLOW}🏷️ 创建 tag...${NC}"
git tag -a "v$new_version" -m "版本 $new_version

$update_notes"

# 推送到远程
echo -e "${YELLOW}📤 推送到远程仓库...${NC}"
git push origin main --tags

echo -e "${GREEN}✅ 版本 $new_version 发布成功！${NC}"
echo -e "${YELLOW}📋 接下来请手动完成：${NC}"
echo "1. 在 GitHub 创建 Release"
echo "2. 更新 Greasy Fork 脚本"
echo "3. 更新 OpenUserJS 脚本"
echo "4. 发布更新公告"

# 打开 GitHub Release 页面（macOS）
if command -v open &> /dev/null; then
    read -p "是否打开 GitHub Release 页面? (y/n): " open_github
    if [ "$open_github" = "y" ]; then
        open "https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/releases/new?tag=v$new_version"
    fi
fi
```

## 📊 Tag 最佳实践

### 1. Tag 命名规范
```bash
# 正确的 tag 命名
v1.0.0
v1.2.3
v2.0.0-beta.1

# 避免的命名
1.0.0 (缺少 v 前缀)
release-1.0.0 (过于冗长)
latest (不明确)
```

### 2. Tag 消息规范
```bash
git tag -a v1.0.1 -m "版本 1.0.1

新增功能：
- 添加录制质量设置
- 支持自定义快捷键

修复问题：
- 修复在 iframe 中的兼容性问题
- 解决内存泄漏问题

改进优化：
- 优化录制文件大小
- 提升录制性能

兼容性：
- Chrome 60+
- Firefox 55+
- Safari 12+"
```

### 3. 分支和 Tag 策略
```
main 分支: 稳定版本，每个提交都应该可以发布
develop 分支: 开发版本，功能开发和测试
feature/* 分支: 功能分支
hotfix/* 分支: 紧急修复分支

Tag 只在 main 分支创建
```

## 🔧 GitHub Actions 自动化

可以创建 GitHub Actions 来自动化发布流程：

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Create Release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: RRWeb 录制工具 ${{ github.ref }}
          body: |
            自动发布版本 ${{ github.ref }}
            
            请查看提交历史了解详细更新内容。
          draft: false
          prerelease: false
```

通过这套完整的版本管理流程，你的项目就能实现规范的版本控制和发布管理了！
