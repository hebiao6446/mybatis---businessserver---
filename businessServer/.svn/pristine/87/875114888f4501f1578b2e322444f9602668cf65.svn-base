<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>修改密码</title>
<style type="text/css">
</style>
</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb"></div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">



								<div class="control-group">
									<label class="control-label">帐号：</label>
									<div class="controls">
										<input type="text" value="${user.account}" readonly="readonly"
											style="width: 200px;" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">旧密码：</label>
									<div class="controls">
										<input type="text" id="oldPassword" name="oldPassword"
											style="width: 200px;" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">新密码：</label>
									<div class="controls">
										<input type="text" id="newPassword"  name="password" style="width: 200px;" />
									</div>
								</div>



								<div class="form-actions" style="padding-left: 200px;">

									<span class="btn btn-warning" onclick="submit_fun()">确&nbsp;&nbsp;定</span>
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
</body>
</html>
<script type="text/javascript">
	$(function() {

	});

	function submit_fun() {
		var anager = {};
		  anager["oldPassword"]=$('#oldPassword').val();
		anager["newPassword"]=$('#newPassword').val();
		if($.trim(anager["oldPassword"]).length==0){
			return;
		}
		if($.trim(anager["newPassword"]).length==0){
			return;
		}
		$.ajax({
			type : "post",
			url : '${ctx}/user!updateUserPass.action',
			dataType : 'json',
			data : anager,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('修改成功');
				} else
					alert('修改失败');

			}
		});
	}
</script>


