# CSS 架构说明

## 文件结构

```
static/css/
├── style.css      # 主样式文件（全局样式、组件样式）
├── pages.css      # 页面特定样式
├── auth.css       # 认证相关页面样式
├── user.css       # 用户相关页面样式
└── README.md      # 本文档
```

## CSS 变量系统

我们使用CSS变量来保持样式的一致性：

### 颜色变量
- `--primary-color`: 主色调（暖橙色）
- `--primary-dark`: 深色主色调
- `--primary-light`: 浅色主色调
- `--secondary-color`: 次要色（深绿色）
- `--accent-color`: 强调色（黄色）

### 间距变量
- `--spacing-xs`: 5px
- `--spacing-sm`: 10px
- `--spacing-md`: 15px
- `--spacing-lg`: 20px
- `--spacing-xl`: 30px
- `--spacing-xxl`: 40px

### 其他变量
- `--transition-fast`: 0.2s ease
- `--transition-normal`: 0.3s ease
- `--shadow-sm/md/lg/hover`: 不同级别的阴影效果

## 优化建议

### 1. 已完成的优化
- ✅ 删除重复的CSS目录
- ✅ 整理CSS文件结构
- ✅ 使用CSS变量统一管理样式
- ✅ 将内联样式提取到独立文件
- ✅ 添加详细的注释和文档结构

### 2. 后续优化建议
1. **CSS压缩**：在生产环境使用压缩版本的CSS文件
2. **CSS合并**：考虑将多个CSS文件合并以减少HTTP请求
3. **使用CSS预处理器**：考虑使用SASS或LESS提高开发效率
4. **引入PostCSS**：自动添加浏览器前缀和优化CSS代码
5. **CSS模块化**：使用CSS Modules或CSS-in-JS解决样式冲突问题

## 使用指南

### 在JSP中引入CSS文件
```jsp
<!-- 基础样式 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

<!-- 页面特定样式 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pages.css">

<!-- 根据需要引入其他样式 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/user.css">
```

### 样式优先级
1. style.css - 基础样式和全局组件
2. pages.css - 页面特定样式
3. auth.css/user.css - 模块特定样式

## 维护建议

1. **保持一致性**：始终使用定义的CSS变量
2. **避免内联样式**：将样式集中管理在CSS文件中
3. **遵循命名规范**：使用BEM或其他一致的命名方法
4. **定期审查**：删除未使用的CSS规则
5. **响应式设计**：确保所有样式都考虑移动端适配 