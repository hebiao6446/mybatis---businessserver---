<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>添加用户</title>
<style type="text/css">
.controls>input {
	width: 267px;
}
</style>
</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">

				<a href="#" class="current">添加用户</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>用户维护</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">
								<div class="control-group">
									<label class="control-label">角色：</label>
									<div class="controls">
										<select id="roleId" name="roleId" class="span4">
											<c:if test="${roleList!=null}">
												<c:forEach items="${roleList}" var="role">
													<option value="${role.roleId}"
														<c:if test="${role.roleId==usersInfo.roleId}">
														selected="selected"</c:if>>${role.name}</option>
												</c:forEach>
											</c:if>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">帐号：</label>
									<div class="controls">
										<input type="text" id="account" name="account" placeholder=""
											value="${usersInfo.account}" /> <span style="color: red"><font
											color="red" id="account_check"> </font>*必填项</span>
									</div>
								</div>


								<div class="control-group">
									<label class="control-label">密码：</label>
									<div class="controls">
										<input type="text" id="password" name="password"
											placeholder="" value="${usersInfo.password}" />
										<span style="color: red"><font
											color="red" id="password_check"> </font>*必填项</span>
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">姓名：</label>
									<div class="controls">
										<input type="text" id="name" name="name" placeholder=""
											value="${usersInfo.name}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">电话：</label>
									<div class="controls">
										<input type="text" id="phone" name="phone" placeholder=""
											value="${usersInfo.phone}" />
												<span style="color: red"><font
											color="red" id="phone_check"> </font>*必填项</span>
									</div>
								</div>


								<div class="form-actions" style="padding-left: 200px;">
									<button class="btn btn-warning" type="button"
										onclick="saveUsersInfo()">确认保存</button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="btn btn-warning" type="button"
										onclick="window.history.go(-1)">&nbsp;&nbsp;返回&nbsp;&nbsp;</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/buttom.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript">
	$(function() {

	});

	function saveUsersInfo() {
		
		var param = {};
		if ($.trim("${usersInfo.userId}") != '') {
			param["userId"] = "${usersInfo.userId}";
		}

		
		if ($.trim($('#account').val()).length == 0) {
			$('#account_check').html('帐号不为空！');
			return;
		}
		if ($.trim($('#phone').val()).length == 0) {
			$('#phone_check').html('手机不为空！');
			return;
		}
		if ($.trim($('#password').val()).length == 0) {
			$('#password_check').html('密码不为空！');
			return;
		}

		param["name"] = $.trim($('#name').val());
		param["roleId"] = $.trim($('#roleId').val());
		param["phone"] = $.trim($('#phone').val());
		param["account"] = $.trim($('#account').val());
		param["password"] = $.trim($('#password').val());
		

		$.ajax({
			type : "post",
			url : '${ctx}/contacts!updateUserInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					window.history.go(-1);
				} else {
					alert(msg.msg);
				}
			}
		});
	}
</script>
</body>
</html>

