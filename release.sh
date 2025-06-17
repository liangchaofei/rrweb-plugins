#!/bin/bash
# RRWeb 录制工具发布脚本
# 使用方法: ./release.sh

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_step() {
    echo -e "${YELLOW}🔄 $1${NC}"
}

# 检查必要的工具
check_requirements() {
    print_step "检查环境要求..."
    
    if ! command -v git &> /dev/null; then
        print_error "Git 未安装"
        exit 1
    fi
    
    if ! command -v sed &> /dev/null; then
        print_error "sed 命令不可用"
        exit 1
    fi
    
    print_success "环境检查通过"
}

# 检查 Git 状态
check_git_status() {
    print_step "检查 Git 状态..."
    
    # 检查是否在 Git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "当前目录不是 Git 仓库"
        exit 1
    fi
    
    # 检查是否在 main 分支
    current_branch=$(git branch --show-current)
    if [ "$current_branch" != "main" ]; then
        print_warning "当前分支: $current_branch"
        read -p "是否切换到 main 分支? (y/n): " switch_branch
        if [ "$switch_branch" = "y" ]; then
            git checkout main
        else
            print_error "请在 main 分支执行发布"
            exit 1
        fi
    fi
    
    # 检查工作区是否干净
    if [ -n "$(git status --porcelain)" ]; then
        print_error "工作区不干净，请先提交所有修改"
        git status
        exit 1
    fi
    
    print_success "Git 状态检查通过"
}

# 拉取最新代码
pull_latest() {
    print_step "拉取最新代码..."
    git pull origin main
    print_success "代码已更新到最新版本"
}

# 获取当前版本
get_current_version() {
    if [ -f "rrweb-recorder.user.js" ]; then
        current_version=$(grep "@version" rrweb-recorder.user.js | sed 's/.*@version[[:space:]]*//' | tr -d ' ')
        print_info "当前版本: $current_version"
    else
        print_error "找不到 rrweb-recorder.user.js 文件"
        exit 1
    fi
}

# 输入新版本号
input_new_version() {
    echo ""
    print_info "版本号格式: MAJOR.MINOR.PATCH (如 1.0.1)"
    print_info "- MAJOR: 不兼容的重大更改"
    print_info "- MINOR: 向下兼容的新功能"
    print_info "- PATCH: 向下兼容的问题修复"
    echo ""
    
    while true; do
        read -p "请输入新版本号: " new_version
        
        # 验证版本号格式
        if [[ $new_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            break
        else
            print_error "版本号格式错误，请使用 x.y.z 格式 (如 1.0.1)"
        fi
    done
    
    print_success "新版本号: $new_version"
}

# 输入更新说明
input_update_notes() {
    echo ""
    print_info "请输入本次更新的说明:"
    print_info "可以包括: 新增功能、修复问题、改进优化等"
    print_info "输入完成后按 Ctrl+D (Linux/Mac) 或 Ctrl+Z (Windows)"
    echo ""
    
    update_notes=$(cat)
    
    if [ -z "$update_notes" ]; then
        update_notes="版本更新"
    fi
    
    print_success "更新说明已记录"
}

# 更新版本号
update_version() {
    print_step "更新版本号..."
    
    # 备份原文件
    cp rrweb-recorder.user.js rrweb-recorder.user.js.bak
    cp package.json package.json.bak
    
    # 更新脚本中的版本号
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/@version.*/@version      $new_version/" rrweb-recorder.user.js
        sed -i '' "s/\"version\": \".*\"/\"version\": \"$new_version\"/" package.json
    else
        # Linux
        sed -i "s/@version.*/@version      $new_version/" rrweb-recorder.user.js
        sed -i "s/\"version\": \".*\"/\"version\": \"$new_version\"/" package.json
    fi
    
    # 删除备份文件
    rm rrweb-recorder.user.js.bak package.json.bak
    
    print_success "版本号已更新为 $new_version"
}

# 提交更改
commit_changes() {
    print_step "提交版本更新..."
    
    git add rrweb-recorder.user.js package.json
    git commit -m "chore: 发布版本 $new_version

$update_notes"
    
    print_success "版本更新已提交"
}

# 创建 Tag
create_tag() {
    print_step "创建 Git Tag..."
    
    tag_message="版本 $new_version

$update_notes

发布时间: $(date '+%Y-%m-%d %H:%M:%S')
提交者: $(git config user.name) <$(git config user.email)>"
    
    git tag -a "v$new_version" -m "$tag_message"
    
    print_success "Tag v$new_version 已创建"
}

# 推送到远程
push_to_remote() {
    print_step "推送到远程仓库..."
    
    git push origin main --tags
    
    print_success "代码和 Tag 已推送到远程仓库"
}

# 显示后续步骤
show_next_steps() {
    echo ""
    print_success "🎉 版本 $new_version 发布成功！"
    echo ""
    print_info "📋 接下来请手动完成以下步骤:"
    echo ""
    echo "1. 📦 在 GitHub 创建 Release:"
    echo "   https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/releases/new?tag=v$new_version"
    echo ""
    echo "2. 🔄 更新 Greasy Fork 脚本:"
    echo "   - 登录 Greasy Fork"
    echo "   - 找到你的脚本并点击更新"
    echo "   - 粘贴新版本代码"
    echo ""
    echo "3. 🔄 更新 OpenUserJS 脚本:"
    echo "   - 登录 OpenUserJS"
    echo "   - 更新脚本代码"
    echo ""
    echo "4. 📢 发布更新公告:"
    echo "   - 技术社区发文"
    echo "   - 社交媒体宣传"
    echo "   - 用户群通知"
    echo ""
    
    # 尝试打开 GitHub Release 页面
    if command -v open &> /dev/null; then
        read -p "是否打开 GitHub Release 页面? (y/n): " open_github
        if [ "$open_github" = "y" ]; then
            open "https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/releases/new?tag=v$new_version"
        fi
    elif command -v xdg-open &> /dev/null; then
        read -p "是否打开 GitHub Release 页面? (y/n): " open_github
        if [ "$open_github" = "y" ]; then
            xdg-open "https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/releases/new?tag=v$new_version"
        fi
    fi
}

# 主函数
main() {
    echo ""
    print_success "🚀 RRWeb 录制工具发布脚本"
    echo ""
    
    check_requirements
    check_git_status
    pull_latest
    get_current_version
    input_new_version
    input_update_notes
    
    echo ""
    print_warning "⚠️  即将执行以下操作:"
    echo "   - 更新版本号: $current_version → $new_version"
    echo "   - 提交代码更改"
    echo "   - 创建 Git Tag: v$new_version"
    echo "   - 推送到远程仓库"
    echo ""
    
    read -p "确认继续? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
        print_info "发布已取消"
        exit 0
    fi
    
    update_version
    commit_changes
    create_tag
    push_to_remote
    show_next_steps
}

# 运行主函数
main
