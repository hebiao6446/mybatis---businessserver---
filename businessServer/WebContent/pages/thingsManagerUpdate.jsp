<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>待办管理</title>
<style type="text/css">
.white_content {
	display: none;
	position: fixed;
	top: 10%;
	left: 35%;
	width: 30%;
	height: auto;
	border: 2px solid lightblue;
	background-color: #efefef;
	z-index: 1002;
	overflow: auto;
}

.dialogInput {
	width: 320px;
	margin-left: 0px;
	background-color: #FFF;
}

.dialogDate {
	width: 90px;
	margin-left: 0px;
	background-color: #FFF;
}

.dialogSelect {
	width: 120px;
	margin-left: 10px;
	background-color: #FFF;
}
</style>
</head>
<body>
	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">待办管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>待办</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">
								<c:if
									test="${things.createUserId!=sessionScope.user.userId&&not empty things.createUserName}">
									<div class="control-group">
										<label class="control-label">创建人：</label>
										<div class="controls">
											<label>${things.createUserName}</label>
										</div>
									</div>
								</c:if>

								<div class="control-group">
									<label class="control-label">待办内容：</label>
									<div class="controls">
										<textarea
											style="width: 500px; height: 100px; margin-left: 5px; background-color: #FFF;"
											class="dialogInput" id="thingsContent" name="thingsContent">${things.content}</textarea>
									</div>
								</div>


								<div class="control-group">
									<label class="control-label">开始时间：</label>
									<div class="controls">
										<input type="text" class="Wdate" id="startTime"
											name="startTime"
											value='<fmt:formatDate value="${things.startTime}" pattern="yyyy-MM-dd"/>'
											onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\');}',dateFmt:'yyyy-MM-dd'})" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">结束时间：</label>
									<div class="controls">

										<input type="text" class="Wdate" id="endTime" name="endTime"
											value='<fmt:formatDate value="${things.endTime}" pattern="yyyy-MM-dd"/>'
											onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\');}',dateFmt:'yyyy-MM-dd'})" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">是否加急：</label>
									<div class="controls">
										<label><input value="T" type="radio"
											name="isEmergency"
											<c:if test="${things.isEmergency=='T'}">checked="checked"</c:if> />加急
										</label><label><input value="F" type="radio"
											name="isEmergency"
											<c:if test="${things.isEmergency=='F'}">checked="checked"</c:if> />不加急</label>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">循环周期：</label>
									<div class="controls">
										<label><input value="0" type="radio" name="periodType"
											<c:if test="${things.periodType=='0'}">checked="checked"</c:if> />不循环
										</label> <label><input value="1" type="radio"
											name="periodType"
											<c:if test="${things.periodType=='1'}">checked="checked"</c:if> />每天
										</label> <label><input value="2" type="radio"
											name="periodType"
											<c:if test="${things.periodType=='2'}">checked="checked"</c:if> />每周</label>
										<label><input value="3" type="radio" name="periodType"
											<c:if test="${things.periodType=='3'}">checked="checked"</c:if> />每月</label>
										<label><input value="4" type="radio" name="periodType"
											<c:if test="${things.periodType=='4'}">checked="checked"</c:if> />每年
										</label>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">待办人员：</label>
									<div class="controls">
										<c:if test="${empty things.createUserName}">
											<div style="margin-bottom: 10px;"
												finishUserId="${sessionScope.user.userId}" deleteFlag="0">
												<span style="width: 100px;">${sessionScope.user.name}</span>
												<span style="width: 100px; margin-left: 30px;">未完成</span>
											</div>
										</c:if>

										<c:forEach var="finish" items="${things.userList}">
											<div style="margin-bottom: 10px;"
												finishUserId="${finish.finishUserId}" deleteFlag="1">
												<span style="width: 100px;">${finish.finishUserName}</span>
												<c:if test="${finish.isFinish=='T'}">
													<span
														style="width: 100px; margin-left: 30px; margin-right: 30px;">已完成</span>
												完成时间：<span style="width: 100px;"><fmt:formatDate
															value="${finish.finishTime}"
															pattern="yyyy-MM-dd HH:mm:ss" /></span>
												</c:if>
												<c:if test="${finish.isFinish=='F'}">
													<span style="width: 100px; margin-left: 30px;">未完成</span>
												</c:if>
												<c:if
													test="${finish.finishUserId!=sessionScope.user.userId&&things.createUserId==sessionScope.user.userId}">
													<a style="cursor: pointer; margin-left: 20px;"
														onclick="deleteThis(this)"><i class="icon-remove"></i>删除</a>
												</c:if>
											</div>
										</c:forEach>
										<c:if
											test="${things.createUserId==sessionScope.user.userId||empty things.createUserName}">
											<div id="addData">
												<a class="btn btn-warning" onclick="selectProduct()">添加人员</a>
											</div>
										</c:if>
									</div>
								</div>
								<div class="form-actions" style="padding-left: 200px;">
									<c:if
										test="${things.createUserId==sessionScope.user.userId||empty things.createUserName}">
										<span class="btn btn-warning" onclick="saveThingsInfo()">保&nbsp;&nbsp;存</span>
									</c:if>
									<span class="btn btn-warning" style="margin-left: 100px;"
										onclick="javascript:history.go(-1);">返&nbsp;&nbsp;回</span>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/buttom.jsp"></jsp:include>

	<div id="divBlack" class="black_overlay"></div>
	<div id="divWhite" class="white_content">
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 365px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i>
					</span>
					<h5 id="title">人员列表</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">
							<div class="productList">
								<ul id="ul_user">
									<c:forEach var="user" items="${users}">
										<c:if test="${user.userId!=sessionScope.user.userId}">
											<li class="li_user"
												<c:forEach items="${things.userList}" var="finishUser">
									<c:if test="${user.userId ==finishUser.finishUserId}">
									style="display:none;"</c:if>									
									</c:forEach>><input
												type="checkbox" value="${user.userId}" /> <span
												name="userName">${user.name}</span></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 30px;"
								onclick="addProduct()">确定</a> <a class="btn btn-success"
								style="margin: 0 30px;"
								onclick="closeDialog('divBlack','divWhite')">取消</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	function addProduct() {
		var array = [];
		$('#ul_user')
				.find('input[type="checkbox"]:checked')
				.each(
						function() {
							var $Obj = $(this).parents('li.li_user');
							$Obj.find('span.checked').attr('class', '');
							$(this).parents('li.li_user').hide();
							$(this).attr('checked', false);
							var userId = $(this).val();
							var b = true;
							$('#addData')
									.prevAll('div[deleteFlag="2"]')
									.each(
											function() {
												if ($(this)
														.attr('finishUserId') == userId) {
													$(this).show();
													b = false;
												}
											});
							if (b) {
								var userName = $Obj.find(
										'span[name="userName"]').html();
								array
										.push('<div style="margin-bottom: 10px;" finishUserId="'+userId+'"  deleteFlag="0">');
								array.push('<span style="width: 100px;">'
										+ userName + '</span>');
								array
										.push('<span style="width: 100px; margin-left: 30px;">未完成</span>');
								array
										.push('<a style="cursor: pointer;margin-left: 20px;" onclick="deleteThis(this)">');
								array
										.push('<i class="icon-remove"></i>删除</a></div>');
							}
						});
		$('#addData').before(array.join(''));
		closeDialog('divBlack', 'divWhite');
	}

	function selectProduct() {
		openDialog('divBlack', 'divWhite');
	}
	function deleteThis(obj) {
		var productId = $(obj).parent().attr('finishUserId');
		$('#ul_user').find('input[value="' + productId + '"]').parents(
				'li.li_user').show();
		var deleteFlag = $(obj).parent().attr('deleteFlag');
		if (deleteFlag == '0') {
			$(obj).parent().remove();
		} else if (deleteFlag == '1') {
			$(obj).parent().attr('deleteFlag', '2');
			$(obj).parent().hide();
		}
	}

	function saveThingsInfo() {
		var things = {};
		things["thingsId"] = '${things.thingsId}';
		things["content"] = $('#thingsContent').val();
		things["startTime"] = $('#startTime').val();
		things["endTime"] = $('#endTime').val();
		things["isEmergency"] = $('input:radio[name="isEmergency"]:checked')
				.val();
		things["periodType"] = $('input:radio[name="periodType"]:checked')
				.val();

		var addUsers = [];
		var deleteUsers = [];
		$('#addData').parents('div.controls').find('div[finishUserId]').each(
				function() {
					if ($(this).attr('deleteFlag') == '0') {
						addUsers.push($(this).attr('finishUserId'));
					} else if ($(this).attr('deleteFlag') == '2') {
						deleteUsers.push($(this).attr('finishUserId'));
					}
				});

		things["addUsers"] = JSON.stringify(addUsers);
		things["deleteUsers"] = JSON.stringify(deleteUsers);
		$.ajax({
			type : "post",
			url : '${ctx}/things!updateThingsInfo.action',
			dataType : 'json',
			data : things,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功！');
					window.history.go(-1);
				} else {
					alert(msg.msg);
				}
			}
		});
	}
</script>


