# 更新链接配置

## 各平台安装链接

### Greasy Fork (推荐)
```
https://greasyfork.org/zh-CN/scripts/123456-rrweb-recorder
```

### OpenUserJS
```
https://openuserjs.org/scripts/your-username/RRWeb_Test_Recorder
```

### GitHub Raw (直接安装)
```
https://raw.githubusercontent.com/your-username/rrweb-recorder/main/rrweb-recorder.user.js
```

### jsDelivr CDN (备用)
```
https://cdn.jsdelivr.net/gh/your-username/rrweb-recorder@main/rrweb-recorder.user.js
```

## 更新检查配置

在脚本头部使用以下配置：

```javascript
// @downloadURL  https://update.greasyfork.org/scripts/123456/rrweb-recorder.user.js
// @updateURL    https://update.greasyfork.org/scripts/123456/rrweb-recorder.meta.js
```

## 版本发布流程

1. **修改代码**
2. **更新版本号** (在脚本头部 @version)
3. **提交到 GitHub**
4. **创建新的 Release**
5. **更新 Greasy Fork**
6. **更新 OpenUserJS**

## 自动化发布脚本

可以创建一个简单的发布脚本：

```bash
#!/bin/bash
# release.sh

# 获取新版本号
read -p "请输入新版本号 (如 1.0.1): " version

# 更新脚本中的版本号
sed -i "s/@version.*/@version      $version/" rrweb-recorder.user.js

# 提交到 Git
git add .
git commit -m "chore: 发布版本 $version"
git tag "v$version"
git push origin main
git push origin "v$version"

echo "版本 $version 已发布到 GitHub"
echo "请手动更新 Greasy Fork 和 OpenUserJS"
```
