<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 个人资料内容（用于AJAX加载到dashboard） -->
<div class="welcome-message">
    <h2><i class="fas fa-user-circle"></i> 个人资料</h2>
    <p>管理您的个人信息和账户设置</p>
    <button class="back-to-dashboard-btn" onclick="backToDashboard()">
        <i class="fas fa-arrow-left"></i> 返回控制面板
    </button>
</div>

<!-- 消息提示区域 -->
<div id="messageArea"></div>



<div class="profile-sections">
    <!-- 基本信息卡片 -->
    <div class="info-card">
        <div class="info-card-header">
            <h3><i class="fas fa-id-card"></i> 基本信息</h3>
                                </div>
        <div class="info-card-body">
                                    <div class="info-row">
                            <div class="info-item">
                                <label>用户名:</label>
                                <div class="info-value-group">
                                    <span id="username-display">${user.username != null ? user.username : '未设置'}</span>
                                    <button class="edit-btn" onclick="editField('username')" title="编辑">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <label>性别:</label>
                                <div class="info-value-group">
                                    <span id="gender-display">
                                        <c:choose>
                                            <c:when test="${user.gender == 1}">男</c:when>
                                            <c:when test="${user.gender == 0}">女</c:when>
                                            <c:otherwise>未设置</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <button class="edit-btn" onclick="editField('gender')" title="编辑">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
        </div>
            </div>
            
    <!-- 联系方式卡片 -->
            <div class="info-card">
        <div class="info-card-header">
            <h3><i class="fas fa-address-book"></i> 联系方式</h3>
        </div>
        <div class="info-card-body">
            <div class="info-row">
                <div class="info-item">
                    <label>手机号码:</label>
                    <div class="info-value-group">
                        <span id="phone-display">${user.phone != null ? user.phone : '未设置'}</span>
                        <button class="edit-btn" onclick="editField('phone')" title="编辑">
                            <i class="fas fa-edit"></i>
                        </button>
                    </div>
            </div>
            
                <div class="info-item">
                    <label>邮箱地址:</label>
                    <div class="info-value-group">
                        <span id="email-display">${user.email != null ? user.email : '未设置'}</span>
                        <button class="edit-btn" onclick="editField('email')" title="编辑">
                            <i class="fas fa-edit"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 安全设置卡片 -->
    <div class="info-card">
        <div class="info-card-header">
            <h3><i class="fas fa-shield-alt"></i> 安全设置</h3>
        </div>
        <div class="info-card-body">
            <div class="security-actions">
                <div class="security-item" onclick="changePassword()">
                    <div class="security-icon">
                        <i class="fas fa-key"></i>
                    </div>
                    <div class="security-text">
                        <h4>修改密码</h4>
                        <p>更新您的登录密码</p>
                    </div>
                    <div class="security-arrow">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>
            </div>
            <p class="security-tip">
                <i class="fas fa-info-circle"></i> 为了您的账户安全，建议定期更换密码
            </p>
        </div>
    </div>
</div>

<!-- 编辑弹窗 -->
<div id="editModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h4 id="modalTitle">编辑信息</h4>
            <span class="close" onclick="closeEditModal()">&times;</span>
        </div>
        <div class="modal-body">
            <form id="editForm">
                <div class="form-group">
                    <label id="fieldLabel">字段名称:</label>
                    <input type="text" id="fieldValue" class="form-control" required>
                    <select id="fieldSelect" class="form-control" style="display: none;">
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeEditModal()">取消</button>
                    <button type="submit" class="btn">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
/* 个人资料页面样式 */
.profile-sections {
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 20px;
    min-height: 500px; /* 确保与控制面板高度一致 */
}

.info-card {
    background: white;
    border: 1px solid #eee;
    border-radius: 5px;
    overflow: hidden;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    transition: all 0.3s ease;
}

.info-card:hover {
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    transform: translateY(-2px);
}

.info-card-header {
    background-color: #f8f9fa;
    padding: 15px 20px;
    border-bottom: 1px solid #eee;
}

.info-card-header h3 {
    margin: 0;
    font-size: 16px;
    color: #333;
    display: flex;
    align-items: center;
}

.info-card-header i {
    margin-right: 8px;
    color: #FF6B35;
}

.info-card-body {
    padding: 20px;
}

.info-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 15px;
}

.info-row:last-child {
    margin-bottom: 0;
}

.info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

.info-item label {
    font-weight: 500;
    color: #666;
    min-width: 80px;
}

.info-value-group {
    display: flex;
    align-items: center;
    gap: 10px;
    flex: 1;
    justify-content: flex-end;
}

.info-value-group span {
    color: #333;
}

.edit-btn {
    background: none;
    border: none;
    color: #999;
    cursor: pointer;
    padding: 4px;
    border-radius: 3px;
    transition: all 0.2s ease;
}

.edit-btn:hover {
    color: #FF6B35;
    background-color: #f8f9fa;
}

.security-actions {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 15px;
}

.security-item {
    display: flex;
    align-items: center;
    padding: 16px;
    background: #f8f9fa;
    border: 1px solid #e9ecef;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.security-item:hover {
    background: #e9ecef;
    border-color: #FF6B35;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(255, 107, 53, 0.15);
}

.security-icon {
    width: 40px;
    height: 40px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    font-size: 16px;
}

.security-item:first-child .security-icon {
    background: #fff3cd;
    color: #856404;
}

.security-item:last-child .security-icon {
    background: #f8d7da;
    color: #721c24;
}

.security-text {
    flex: 1;
}

.security-text h4 {
    margin: 0 0 4px 0;
    font-size: 14px;
    font-weight: 600;
    color: #333;
}

.security-text p {
    margin: 0;
    font-size: 12px;
    color: #666;
}

.security-arrow {
    color: #adb5bd;
    font-size: 12px;
}

.back-to-dashboard-btn {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    background: #FF6B35;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.3s ease;
}

.back-to-dashboard-btn:hover {
    background: #E05A2A;
    transform: translateY(-50%) translateX(-2px);
}

.security-tip {
    background-color: #f8f9fa;
    border-left: 3px solid #FF6B35;
    padding: 10px 15px;
    margin: 0;
    border-radius: 0 4px 4px 0;
    color: #666;
    font-size: 14px;
}

.security-tip i {
    color: #FF6B35;
    margin-right: 5px;
}

/* 模态框样式 */
.modal {
    position: fixed;
    z-index: 10000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal-content {
    background-color: #fefefe;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 90%;
    max-width: 400px;
    max-height: 90vh;
    overflow-y: auto;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 20px 0;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
}

.modal-header h4 {
    margin: 0;
    color: #333;
}

.close {
    color: #aaa;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
    line-height: 1;
}

.close:hover {
    color: #FF6B35;
}

.modal-body {
    padding: 0 20px 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #555;
}

.form-control {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    transition: border-color 0.3s ease;
    box-sizing: border-box;
}

.form-control:focus {
    outline: none;
    border-color: #FF6B35;
    box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.1);
}

.form-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
    margin-top: 20px;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
}

.btn-secondary:hover {
    background-color: #5a6268;
}

/* 安全设置样式 */
.security-actions {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.security-item {
    display: flex;
    align-items: center;
    padding: 15px;
    border: 1px solid #eee;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.security-item:hover {
    background-color: #f8f9fa;
    border-color: #ff6b35;
}

.security-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #ff6b35;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
}

.security-text {
    flex: 1;
}

.security-text h4 {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #333;
}

.security-text p {
    margin: 0;
    font-size: 14px;
    color: #666;
}

.security-arrow {
    color: #ccc;
    font-size: 16px;
}

.security-tip {
    margin-top: 15px;
    padding: 10px;
    background-color: #f8f9fa;
    border-radius: 4px;
    font-size: 14px;
    color: #666;
    display: flex;
    align-items: center;
    gap: 8px;
}

.alert {
    padding: 12px 16px;
    border-radius: 4px;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.alert-success {
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
}

.alert-error {
    background-color: #f8d7da;
    border: 1px solid #f5c6cb;
    color: #721c24;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .info-row {
        grid-template-columns: 1fr;
        gap: 10px;
    }
    
    .info-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 5px;
    }
    
    .info-value-group {
        justify-content: flex-start;
        width: 100%;
    }
    
    .security-actions {
        flex-direction: column;
    }
    
    .security-item {
        flex-direction: column;
        text-align: center;
        gap: 10px;
    }
    
    .security-icon {
        margin-right: 0;
        margin-bottom: 10px;
    }
}
</style>

<script>
// 全局变量
var currentField = '';

// 直接定义为全局函数
function editField(field) {
    try {
        console.log('editField called with:', field); 
        
        currentField = field;
        const modal = document.getElementById('editModal');
        
        if (!modal) {
            console.error('Modal element not found!');
            alert('模态框元素未找到，请刷新页面重试');
            return;
        }
        
        const title = document.getElementById('modalTitle');
        const label = document.getElementById('fieldLabel');
        const input = document.getElementById('fieldValue');
        const select = document.getElementById('fieldSelect');
        const currentValue = document.getElementById(field + '-display').textContent.trim();
        
        console.log('Modal element:', modal); // 调试日志
        console.log('Current value:', currentValue); // 调试日志
        
        // 重置表单
        input.style.display = 'block';
        select.style.display = 'none';
        input.type = 'text'; // 重置input类型
        
        switch(field) {
            case 'username':
                title.textContent = '编辑用户名';
                label.textContent = '用户名:';
                input.value = currentValue === '未设置' ? '' : currentValue;
                break;
            case 'phone':
                title.textContent = '编辑手机号码';
                label.textContent = '手机号码:';
                input.value = currentValue === '未设置' ? '' : currentValue;
                input.type = 'tel';
                break;
            case 'email':
                title.textContent = '编辑邮箱地址';
                label.textContent = '邮箱地址:';
                input.value = currentValue === '未设置' ? '' : currentValue;
                input.type = 'email';
                break;
            case 'gender':
                title.textContent = '设置性别';
                label.textContent = '性别:';
                input.style.display = 'none';
                select.style.display = 'block';
                const genderValue = currentValue === '男' ? '1' : (currentValue === '女' ? '0' : '');
                select.value = genderValue;
                break;
            default:
                input.type = 'text';
        }
        
        modal.style.display = 'flex';
        modal.style.zIndex = '10000'; // 确保在最上层
        console.log('Modal should be visible now');
        
        // 聚焦到第一个可见的输入框
        setTimeout(() => {
            if (input.style.display !== 'none') {
                input.focus();
            } else {
                select.focus();
            }
        }, 100);
        
    } catch (error) {
        console.error('Error in editField:', error);
        alert('发生错误：' + error.message);
    }
}

// 直接定义为全局函数
function closeEditModal() {
    const modal = document.getElementById('editModal');
    if (modal) {
        modal.style.display = 'none';
    }
    const fieldValue = document.getElementById('fieldValue');
    if (fieldValue) {
        fieldValue.type = 'text';
    }
}

// 直接定义为全局函数
function changePassword() {
    // 创建密码修改弹窗
    const modal = document.getElementById('editModal');
    const title = document.getElementById('modalTitle');
    const modalBody = document.querySelector('.modal-body');
    
    title.textContent = '修改密码';
    
    // 创建密码修改表单
    modalBody.innerHTML = `
        <form id="passwordForm">
            <div class="form-group">
                <label>当前密码:</label>
                <input type="password" id="currentPassword" class="form-control" required>
            </div>
            <div class="form-group">
                <label>新密码:</label>
                <input type="password" id="newPassword" class="form-control" required minlength="6">
                <small class="form-text">至少6位字符</small>
            </div>
            <div class="form-group">
                <label>确认新密码:</label>
                <input type="password" id="confirmPassword" class="form-control" required>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">取消</button>
                <button type="submit" class="btn">确定</button>
            </div>
        </form>
    `;
    
    modal.style.display = 'flex';
    
    // 绑定表单提交事件
    document.getElementById('passwordForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (newPassword !== confirmPassword) {
            showMessageInArea('两次输入的密码不一致', 'error');
            return;
        }
        
        if (newPassword.length < 6) {
            showMessageInArea('新密码至少需要6位字符', 'error');
            return;
        }
        
        // 发送密码修改请求
        fetch('${pageContext.request.contextPath}/user/profile/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'currentPassword=' + encodeURIComponent(currentPassword) + 
                  '&newPassword=' + encodeURIComponent(newPassword)
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            if (data.success) {
                showMessageInArea('密码修改成功！', 'success');
                closeEditModal();
            } else {
                showMessageInArea(data.message || '密码修改失败', 'error');
            }
        })
        .catch(function(error) {
            console.error('Error:', error);
            showMessageInArea('网络错误，请稍后重试', 'error');
        });
    });
}

function showMessageInArea(message, type) {
    const messageArea = document.getElementById('messageArea');
    const alertClass = type === 'success' ? 'alert-success' : 'alert-error';
    const icon = type === 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-triangle';
    
    messageArea.innerHTML = '<div class="alert ' + alertClass + '"><i class="' + icon + '"></i> ' + message + '</div>';
    
    // 滚动到消息区域
    messageArea.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    
    // 3秒后自动隐藏成功消息
    if (type === 'success') {
        setTimeout(function() {
            messageArea.innerHTML = '';
        }, 3000);
    }
}

function backToDashboard() {
    // 直接重定向到用户面板
    window.location.href = '${pageContext.request.contextPath}/user/dashboard';
}

// 移除重复的事件监听器，已在DOMContentLoaded中处理

function updateUserField(field, value) {
    // 发送AJAX请求到新的API端点
    fetch('${pageContext.request.contextPath}/user/updateProfile', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: field + '=' + encodeURIComponent(value)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 更新显示值
            let displayValue = value;
            if (field === 'gender') {
                displayValue = value === '1' ? '男' : (value === '0' ? '女' : '未设置');
            }
            
            document.getElementById(field + '-display').textContent = displayValue || '未设置';
            closeEditModal();
            
            // 显示成功消息
            showMessageInArea('更新成功！', 'success');
        } else {
            showMessageInArea(data.message || '更新失败', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showMessageInArea('网络错误，请稍后重试', 'error');
    });
}

function showMessage(message, type) {
    // 创建消息提示
    const messageDiv = document.createElement('div');
    messageDiv.className = 'message ' + type;
    messageDiv.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message;
    
    // 使用字符串连接而不是模板字符串，避免JSP EL表达式冲突
    const bgColor = type === 'success' ? '#d4edda' : '#f8d7da';
    const textColor = type === 'success' ? '#155724' : '#721c24';
    const borderColor = type === 'success' ? '#c3e6cb' : '#f5c6cb';
    
    messageDiv.style.cssText = 
        'position: fixed;' +
        'top: 20px;' +
        'right: 20px;' +
        'background: ' + bgColor + ';' +
        'color: ' + textColor + ';' +
        'border: 1px solid ' + borderColor + ';' +
        'border-radius: 4px;' +
        'padding: 12px 16px;' +
        'z-index: 1001;' +
        'box-shadow: 0 2px 5px rgba(0,0,0,0.2);' +
        'font-size: 14px;' +
        'min-width: 200px;';
    
    document.body.appendChild(messageDiv);
    
    // 3秒后自动移除
    setTimeout(() => {
        messageDiv.remove();
    }, 3000);
}

// 初始化函数
function initProfilePage() {
    console.log('Initializing profile page');
    
    // 确保所有函数都可用
    if (typeof window.editField !== 'function') {
        console.error('editField function not available!');
        return;
    }
    
    // 表单提交处理
    const editForm = document.getElementById('editForm');
    if (editForm) {
        editForm.removeEventListener('submit', handleFormSubmit);
        editForm.addEventListener('submit', handleFormSubmit);
        console.log('Form event listener added');
    }
    
    // 点击模态框外部关闭
    const editModal = document.getElementById('editModal');
    if (editModal) {
        editModal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeEditModal();
            }
        });
        console.log('Modal click listener added');
    }
    
    // 测试编辑按钮
    const editButtons = document.querySelectorAll('.edit-btn');
    console.log('Found ' + editButtons.length + ' edit buttons');
}

// 表单提交处理函数
function handleFormSubmit(e) {
    e.preventDefault();
    
    const fieldValue = document.getElementById('fieldValue').style.display === 'none' 
        ? document.getElementById('fieldSelect').value 
        : document.getElementById('fieldValue').value;
    
    if (!fieldValue.trim() && currentField !== 'gender') {
        alert('请输入有效的值');
        return;
    }
    
    // 发送AJAX请求到后端
    updateUserField(currentField, fieldValue);
}

// 明确将所有函数暴露到全局作用域
window.editField = editField;
window.closeEditModal = closeEditModal; 
window.changePassword = changePassword;
window.backToDashboard = backToDashboard;
window.showMessageInArea = showMessageInArea;
window.updateUserField = updateUserField;
window.initProfilePage = initProfilePage;
window.handleFormSubmit = handleFormSubmit;

// 立即初始化
console.log('Profile page script loaded');
console.log('Global functions exposed:', {
    editField: typeof window.editField,
    closeEditModal: typeof window.closeEditModal,
    changePassword: typeof window.changePassword,
    backToDashboard: typeof window.backToDashboard
});

// 延迟初始化确保DOM准备就绪
setTimeout(function() {
    const modal = document.getElementById('editModal');
    const editButtons = document.querySelectorAll('.edit-btn');
    
    console.log('DOM check - Modal exists:', !!modal);
    console.log('DOM check - Edit buttons found:', editButtons.length);
    
    if (modal && editButtons.length > 0) {
        console.log('Initializing profile page...');
        initProfilePage();
    } else {
        console.log('DOM not ready, will retry...');
        // 如果DOM还没准备好，继续重试
        var retryCount = 0;
        var maxRetries = 10;
        
        function retryInit() {
            retryCount++;
            const modal = document.getElementById('editModal');
            const editButtons = document.querySelectorAll('.edit-btn');
            
            if (modal && editButtons.length > 0) {
                console.log('Retry successful, initializing...');
                initProfilePage();
            } else if (retryCount < maxRetries) {
                console.log('Retry ' + retryCount + '/' + maxRetries + '...');
                setTimeout(retryInit, 300);
            } else {
                console.error('Failed to initialize after ' + maxRetries + ' retries');
            }
        }
        
        setTimeout(retryInit, 300);
    }
}, 100);
</script> 