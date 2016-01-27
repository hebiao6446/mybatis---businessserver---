<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>联系人管理</title>
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

				<a href="${ctx}/pages/contactsManagerList.jsp" title="联系人管理"
					class="tip-bottom"> <i class="icon-home"></i>联系人管理
				</a> <a href="#" class="current">联系人维护</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>联系人维护</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">
								<div class="control-group">
									<label class="control-label">联系人分组：</label>
									<div class="controls">
										<select id="groupId" name="groupId" class="span4">
											<c:if test="${groupList!=null}">
												<c:forEach items="${groupList}" var="group">
													<option value="${group.groupId}"
														<c:if test="${group.groupId==contactsInfo.groupId}">
														selected="selected"</c:if>>${group.name}</option>
												</c:forEach>
											</c:if>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">企业名称：</label>
									<div class="controls">
										<input type="text" id="company" name="company" placeholder=""
											value="${contactsInfo.company}" /> <span style="color: red"><font
											color="red" id="title_check"> </font>*必填项</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">姓名：</label>
									<div class="controls">
										<input type="text" id="name" name="name" placeholder=""
											value="${contactsInfo.name}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">职务：</label>
									<div class="controls">
										<input type="text" id="job" name="job" placeholder=""
											value="${contactsInfo.job}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">手机：</label>
									<div class="controls">
										<input type="text" id="mobile" name="mobile" placeholder=""
											value="${contactsInfo.mobile}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">电话：</label>
									<div class="controls">
										<input type="text" id="phone" name="phone" placeholder=""
											value="${contactsInfo.phone}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">传真：</label>
									<div class="controls">
										<input type="text" id="fax" name="fax" placeholder=""
											value="${contactsInfo.fax}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">QQ：</label>
									<div class="controls">
										<input type="text" id="qq" name="qq" placeholder=""
											value="${contactsInfo.qq}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">邮箱：</label>
									<div class="controls">
										<input type="text" id="email" name="email" placeholder=""
											value="${contactsInfo.email}" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">主营业务：</label>
									<div class="controls">
										<input type="text" id="business" name="business"
											placeholder="" value="${contactsInfo.business}" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">地址：</label>
									<div class="controls">
										<input type="text" id="address" name="address" placeholder=""
											value="${contactsInfo.address}" />
									</div>
								</div>




								<div class="form-actions" style="padding-left: 200px;">
									<button class="btn btn-warning" type="button"
										onclick="saveContactsInfo()">确认保存</button>
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

	function saveContactsInfo() {
		var param = {
			contactsId : "${contactsInfo.contactsId}"
		};
		if ($.trim($('#company').val()).length == 0) {
			$('#company_check').html('名称不为空！');
			return;
		}
		param["groupId"] = $('#groupId').val();
		param["company"] = $.trim($('#company').val());
		param["name"] = $.trim($('#name').val());
		param["job"] = $.trim($('#job').val());
		param["mobile"] = $.trim($('#mobile').val());
		param["phone"] = $.trim($('#phone').val());
		param["fax"] = $.trim($('#fax').val());
		param["qq"] = $.trim($('#qq').val());
		param["email"] = $.trim($('#email').val());
		param["address"] = $.trim($('#address').val());
		param["business"] = $.trim($('#business').val());

		$.ajax({
			type : "post",
			url : '${ctx}/contacts!updateContactsInfo.action',
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

