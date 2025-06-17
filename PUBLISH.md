# 发布指南

本文档介绍如何发布和分发 RRWeb 录制工具油猴脚本。

## 发布平台

### 1. GitHub (推荐)

#### 创建仓库
```bash
# 初始化 Git 仓库
git init
git add .
git commit -m "Initial commit: RRWeb recorder userscript"

# 添加远程仓库
git remote add origin https://github.com/your-username/rrweb-recorder.git
git branch -M main
git push -u origin main
```

#### 设置 GitHub Pages (可选)
1. 进入仓库设置 → Pages
2. 选择 Source: Deploy from a branch
3. 选择 Branch: main
4. 访问 `https://your-username.github.io/rrweb-recorder/replay-example.html` 查看回放工具

#### 创建 Release
1. 在 GitHub 仓库页面点击 "Releases"
2. 点击 "Create a new release"
3. 标签版本: `v1.0.0`
4. 发布标题: `RRWeb 录制工具 v1.0.0`
5. 描述发布内容和更新日志
6. 上传 `rrweb-recorder.user.js` 文件

### 2. Greasy Fork (推荐)

[Greasy Fork](https://greasyfork.org/) 是最大的用户脚本分享平台。

#### 发布步骤
1. 注册 Greasy Fork 账号
2. 点击 "发布脚本"
3. 粘贴 `rrweb-recorder.user.js` 内容
4. 填写脚本信息：
   - 名称: RRWeb 测试录制工具
   - 描述: 使用rrweb录制网页操作，方便测试同学快速定位问题
   - 许可证: MIT
   - 标签: recording, testing, rrweb, automation
5. 提交审核

#### 更新脚本
1. 修改脚本中的 `@version` 版本号
2. 在 Greasy Fork 中点击 "更新"
3. 粘贴新版本代码
4. 提交更新

### 3. OpenUserJS

[OpenUserJS](https://openuserjs.org/) 是另一个用户脚本平台。

#### 发布步骤
1. 注册 OpenUserJS 账号
2. 点击 "New Script"
3. 上传 `rrweb-recorder.user.js` 文件
4. 填写脚本信息
5. 发布

### 4. 直接分发

#### 通过 GitHub Raw 链接
用户可以直接通过以下链接安装：
```
https://raw.githubusercontent.com/your-username/rrweb-recorder/main/rrweb-recorder.user.js
```

#### 通过 jsDelivr CDN
```
https://cdn.jsdelivr.net/gh/your-username/rrweb-recorder@main/rrweb-recorder.user.js
```

## 自动更新配置

确保脚本头部包含正确的更新链接：

```javascript
// @downloadURL  https://raw.githubusercontent.com/your-username/rrweb-recorder/main/rrweb-recorder.user.js
// @updateURL    https://raw.githubusercontent.com/your-username/rrweb-recorder/main/rrweb-recorder.user.js
```

## 版本管理

### 版本号规则
使用语义化版本号 (Semantic Versioning):
- `1.0.0` - 主版本.次版本.修订版本
- 主版本: 不兼容的 API 修改
- 次版本: 向下兼容的功能性新增
- 修订版本: 向下兼容的问题修正

### 更新流程
1. 修改代码
2. 更新 `@version` 版本号
3. 更新 `package.json` 中的版本号
4. 提交到 Git
5. 创建新的 Release
6. 更新各平台的脚本

## 推广策略

### 1. 社区分享
- 在相关技术论坛分享 (如掘金、CSDN、博客园)
- 在 QQ 群、微信群中分享
- 在公司内部推广使用

### 2. 文档完善
- 编写详细的使用教程
- 制作使用演示视频
- 提供常见问题解答

### 3. 功能展示
- 创建在线演示页面
- 提供示例录制文件
- 展示实际使用场景

## 维护指南

### 定期更新
- 跟进 rrweb 库的更新
- 修复发现的 bug
- 根据用户反馈改进功能

### 用户支持
- 及时回复 GitHub Issues
- 在各平台回复用户评论
- 收集用户需求和建议

### 兼容性测试
- 定期在不同浏览器中测试
- 测试不同网站的兼容性
- 确保新版本的稳定性

## 法律注意事项

### 许可证
- 使用 MIT 许可证，允许自由使用和修改
- 保留原作者版权信息

### 隐私保护
- 明确说明数据不会上传到服务器
- 提供隐私保护功能（如密码遮蔽）
- 遵守相关法律法规

### 免责声明
在 README 中添加免责声明：
```
本工具仅用于测试和调试目的，使用者需要遵守相关法律法规，
不得用于非法用途。作者不承担因使用本工具而产生的任何责任。
```

## 统计和分析

### 使用统计
- GitHub Stars 和 Forks 数量
- Greasy Fork 安装量和评分
- 用户反馈和评论

### 改进方向
- 根据用户反馈优化界面
- 添加更多录制选项
- 提供更好的回放体验
- 支持更多导出格式

## 联系方式

为用户提供反馈渠道：
- GitHub Issues: 报告 bug 和功能请求
- 邮箱: your-email@example.com
- QQ 群: 123456789 (可选)

---

按照以上指南，你的 RRWeb 录制工具就可以成功发布并被用户使用了！
