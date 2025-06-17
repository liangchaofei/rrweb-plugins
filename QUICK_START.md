# 🚀 快速发布指南

## 📋 发布前检查清单

- [ ] 代码已完成开发和测试
- [ ] 所有文件已提交到 Git
- [ ] 当前在 main 分支
- [ ] 工作区干净（无未提交的修改）

## 🎯 一键发布

### 方法一：使用自动化脚本（推荐）

```bash
# 给脚本执行权限（首次使用）
chmod +x release.sh

# 运行发布脚本
./release.sh
```

脚本会自动完成：
1. ✅ 环境检查
2. ✅ 拉取最新代码  
3. ✅ 版本号更新
4. ✅ 提交更改
5. ✅ 创建 Git Tag
6. ✅ 推送到远程

### 方法二：手动操作

```bash
# 1. 更新版本号（编辑文件）
# 修改 rrweb-recorder.user.js 中的 @version
# 修改 package.json 中的 version

# 2. 提交更改
git add .
git commit -m "chore: 发布版本 1.0.1"

# 3. 创建 Tag
git tag -a v1.0.1 -m "版本 1.0.1 - 修复录制问题"

# 4. 推送到远程
git push origin main --tags
```

## 📦 发布后操作

### 1. GitHub Release
1. 访问: `https://github.com/your-username/rrweb-recorder/releases`
2. 点击 "Create a new release"
3. 选择刚创建的 tag
4. 填写发布说明
5. 上传 `rrweb-recorder.user.js` 文件
6. 点击 "Publish release"

### 2. Greasy Fork 更新
1. 登录 [Greasy Fork](https://greasyfork.org/)
2. 进入你的脚本管理页面
3. 点击脚本名称进入编辑
4. 更新代码内容
5. 点击 "更新脚本"

### 3. OpenUserJS 更新
1. 登录 [OpenUserJS](https://openuserjs.org/)
2. 进入脚本管理页面
3. 上传新版本文件
4. 更新描述信息

## 🔗 重要链接模板

发布成功后，更新以下链接：

```markdown
## 安装链接

### 主要平台
- **Greasy Fork**: https://greasyfork.org/zh-CN/scripts/YOUR_SCRIPT_ID
- **OpenUserJS**: https://openuserjs.org/scripts/YOUR_USERNAME/RRWeb_Test_Recorder

### 直接安装
- **GitHub Release**: https://github.com/YOUR_USERNAME/rrweb-recorder/releases/latest/download/rrweb-recorder.user.js
- **GitHub Raw**: https://raw.githubusercontent.com/YOUR_USERNAME/rrweb-recorder/main/rrweb-recorder.user.js
- **jsDelivr CDN**: https://cdn.jsdelivr.net/gh/YOUR_USERNAME/rrweb-recorder@main/rrweb-recorder.user.js

### 项目主页
- **GitHub**: https://github.com/YOUR_USERNAME/rrweb-recorder
- **演示页面**: https://YOUR_USERNAME.github.io/rrweb-recorder/replay-example.html
```

## 📊 版本号规范

### 语义化版本 (SemVer)
- `1.0.0` → `1.0.1` - 修复 bug
- `1.0.0` → `1.1.0` - 新增功能
- `1.0.0` → `2.0.0` - 重大更新

### 示例场景
```
1.0.0 - 首次发布
1.0.1 - 修复录制按钮不显示
1.0.2 - 修复下载文件名问题
1.1.0 - 添加快捷键支持
1.1.1 - 修复快捷键冲突
2.0.0 - 重构代码，API 变更
```

## 🎉 发布成功标志

✅ **Git Tag 创建成功**
```bash
git tag -l  # 应该能看到新的 v1.x.x tag
```

✅ **远程仓库已更新**
```bash
git log --oneline -5  # 应该能看到版本提交
```

✅ **GitHub Release 页面显示新版本**

✅ **Greasy Fork 显示新版本**

✅ **用户可以正常安装和更新**

## 🐛 常见问题

### Q: Tag 推送失败
```bash
# 删除本地 tag 重新创建
git tag -d v1.0.1
git tag -a v1.0.1 -m "版本说明"
git push origin v1.0.1
```

### Q: 版本号更新错误
```bash
# 修改文件后重新提交
git add .
git commit --amend -m "chore: 发布版本 1.0.1"
```

### Q: 需要回滚版本
```bash
# 回滚到上一个版本
git reset --hard HEAD~1
git push origin main --force-with-lease
```

## 📞 获取帮助

- 📖 详细文档: `VERSION_MANAGEMENT.md`
- 🧪 测试清单: `TEST_CHECKLIST.md`  
- 📢 推广指南: `PROMOTION.md`
- 🐛 问题反馈: GitHub Issues

---

按照这个快速指南，你就能轻松完成版本发布了！🎉
