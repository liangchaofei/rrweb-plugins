# RRWeb 测试录制工具

一个基于 [rrweb](https://www.rrweb.io/) 的油猴脚本，用于录制网页操作，方便测试同学快速定位问题。

## 功能特性

- 🎥 **一键录制** - 点击悬浮按钮即可开始/停止录制
- 📱 **悬浮控制** - 右下角悬浮按钮，不影响页面操作
- 💾 **自动下载** - 录制完成后自动下载 JSON 格式的录制文件
- 🔒 **隐私保护** - 自动遮蔽密码等敏感信息
- 🌐 **全站支持** - 支持所有网站（`*://*/*`）
- 📊 **详细信息** - 包含录制时间、URL、用户代理等元信息

## 安装方法

### 方法一：直接安装（推荐）

1. 安装油猴脚本管理器：
   - Chrome: [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo)
   - Firefox: [Tampermonkey](https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/) 或 [Greasemonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/)
   - Safari: [Tampermonkey](https://apps.apple.com/us/app/tampermonkey/id1482490089)
   - Edge: [Tampermonkey](https://microsoftedge.microsoft.com/addons/detail/tampermonkey/iikmkjmpaadaobahmlepeloendndfphd)

2. 点击安装脚本：
   ```
   https://raw.githubusercontent.com/your-username/rrweb-recorder/main/rrweb-recorder.user.js
   ```

### 方法二：手动安装

1. 复制 `rrweb-recorder.user.js` 文件内容
2. 打开 Tampermonkey 管理面板
3. 点击 "创建新脚本"
4. 粘贴代码并保存

## 使用方法

1. **开始录制**：
   - 访问任意网页
   - 点击右下角的绿色"开始录制"按钮
   - 按钮变为红色"停止录制"状态，开始录制用户操作

2. **停止录制**：
   - 点击红色"停止录制"按钮
   - 自动下载录制文件（JSON格式）

3. **查看录制**：
   - 录制文件可以通过 rrweb 的播放器回放
   - 或者发送给开发人员进行问题分析

## 录制文件格式

录制完成后会下载一个 JSON 文件，包含以下信息：

```json
{
  "events": [...],          // rrweb 事件数据
  "startTime": 1640995200000,  // 录制开始时间戳
  "endTime": 1640995260000,    // 录制结束时间戳
  "url": "https://example.com", // 录制页面URL
  "userAgent": "...",          // 浏览器信息
  "timestamp": "2021-12-31T16:00:00.000Z" // ISO格式时间戳
}
```

## 回放录制文件

### 在线回放

可以使用 rrweb 官方提供的在线播放器：
1. 访问 [rrweb.io](https://www.rrweb.io/)
2. 上传录制的 JSON 文件进行回放

### 本地回放

创建一个简单的 HTML 文件：

```html
<!DOCTYPE html>
<html>
<head>
    <title>录制回放</title>
    <script src="https://cdn.jsdelivr.net/npm/rrweb@latest/dist/rrweb.min.js"></script>
</head>
<body>
    <div id="player"></div>
    <script>
        // 将录制的 events 数据粘贴到这里
        const events = [...]; // 你的录制数据
        
        const replayer = new rrweb.Replayer(events);
        replayer.mount(document.getElementById('player'));
        replayer.play();
    </script>
</body>
</html>
```

## 配置选项

脚本支持以下配置（可在代码中修改）：

- `checkoutEveryNms`: 检查点间隔（默认10秒）
- `maskTextSelector`: 需要遮蔽的文本选择器
- `maskInputOptions`: 输入框遮蔽选项
  - `password: true` - 遮蔽密码框
  - `email: false` - 不遮蔽邮箱框
  - `text: false` - 不遮蔽普通文本框

## 隐私说明

- 脚本会自动遮蔽密码输入框的内容
- 可以通过 `data-sensitive` 属性标记需要遮蔽的元素
- 录制数据仅保存在本地，不会上传到任何服务器

## 故障排除

### 常见问题

1. **按钮不显示**
   - 检查是否安装了油猴脚本管理器
   - 确认脚本已启用
   - 刷新页面重试

2. **录制失败**
   - 检查浏览器控制台是否有错误信息
   - 确认 rrweb 库加载成功
   - 尝试在其他网站测试

3. **下载失败**
   - 检查浏览器是否阻止了下载
   - 确认浏览器允许该网站下载文件

### 兼容性

- ✅ Chrome 60+
- ✅ Firefox 55+
- ✅ Safari 12+
- ✅ Edge 79+

## 开发

### 本地开发

1. 克隆仓库：
   ```bash
   git clone https://github.com/your-username/rrweb-recorder.git
   cd rrweb-recorder
   ```

2. 修改脚本文件
3. 在 Tampermonkey 中重新加载脚本

### 发布更新

1. 更新版本号（在脚本头部的 `@version`）
2. 提交到 GitHub
3. 用户的 Tampermonkey 会自动检查更新

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！

## 相关链接

- [rrweb 官网](https://www.rrweb.io/)
- [rrweb GitHub](https://github.com/rrweb-io/rrweb)
- [Tampermonkey 官网](https://www.tampermonkey.net/)
