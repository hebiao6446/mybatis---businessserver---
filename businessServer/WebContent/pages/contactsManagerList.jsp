<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>联系人管理</title>
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
	left: 35%;
	width: 30%;
	height: auto;
}

.menu {
	color: red;
	text-align: center;
	cursor: pointer;
}

.condition {
	float: right;
	margin: 10px 20px;
	font-size: 14px;
	color: red;
	font-weight: bold;
	cursor: pointer;
}

.dialogInput {
	width: 220px;
	margin-left: 10px;
	background-color: #FFF;
}

.dialogDate {
	width: 90px;
	margin-left: 10px;
	background-color: #FFF;
}

.dialogSelect {
	width: 214px;
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

				<a href="#" class="current">联系人管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>联系人列表</h5>
							<span class="condition" onclick="conditionQuery()">条件查询</span>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="2%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="8%" style="font-size: 12px;">姓名</th>
									<th width="15%" style="font-size: 12px;">职务</th>
									<th width="20%" style="font-size: 12px;">公司名称</th>
									<th width="35%" style="font-size: 12px;">地址</th>
									<th width="10%" style="font-size: 10px;">来源</th>
									<th width="10%" style="font-size: 12px;">分组</th>
								</tr>
							</thead>
							<tbody id="table_content">

							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
						<div class="widget-title"
							style="height: 40px; border: 1px solid #ccc; padding: 20px;">
							<a class="btn btn-warning" style="margin: 0 10px;"
								onclick="window.location.href='${ctx}/contacts!findContactsInfo.action'">新&nbsp;&nbsp;&nbsp;&nbsp;增</a>
							<a class="btn btn-warning" style="margin: 0 10px;"
								onclick="deleteData()">删&nbsp;&nbsp;&nbsp;&nbsp;除</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<jsp:include page="/common/buttom.jsp"></jsp:include>

	<div id="divBlack" class="black_overlay"></div>
	<div id="divWhite" class="white_content">
		<input type="hidden" id="roleId" />
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 370px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i>
					</span>
					<h5 id="title">联系人查询条件:</h5>
				</div>
				<div class="widget-content nopadding">
					<form id="conditions" class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 110px;">直属人员：</label>
							<div class="controls" style="margin-left: 110px;">
								<select id="userId" name="userId" class="dialogSelect">
									<option value="" selected="selected">&nbsp;</option>
									<option selected="selected" value="${sessionScope.user.userId}">${sessionScope.user.name}</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">公司名称：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="company" name="company"
									class="dialogInput" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">联系人姓名：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="contactsName" name="contactsName"
									class="dialogInput" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">手机(电话)：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="phone" name="phone" class="dialogInput" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">职业：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="job" name="job" class="dialogInput" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">主营业务：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="business" name="business"
									class="dialogInput" />
							</div>
						</div>

						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 30px;"
								onclick="queryInfo()">查询</a> <a class="btn btn-success"
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
	var rowData = [];
	$(function() {
		loadData(1);
		$.ajax({
			type : "post",
			url : '${ctx}/contacts!findMySubContactsList.action',
			dataType : 'json',
			data : {},
			success : function(msg, status) {
				if (msg.status == 200) {
					loadData(1);
					var array = [];
					for ( var i = 0; i < msg.rows.length; i++) {
						var datas = msg.rows[i];
						array.push('<option value="'+datas["userId"]+'">'
								+ datas["name"] + '</option>');
					}
					$('#userId').append(array.join(''));
				} else {
					alert(msg.msg);
				}
			}
		});
	});
	function loadData(page, size) {
		if (size != undefined) {
			pageinfo["size"] = size;
			$('#pagesize').html(size);
		}
		if (page == -1)
			pageinfo["page"]--;
		else if (page == -2)
			pageinfo["page"]++;
		else {
			if (page >= pageinfo["tp"] && pageinfo["tp"] > 0)
				pageinfo["page"] = pageinfo["tp"];
			else
				pageinfo["page"] = page;
		}

		pageinfo["userId"] = $.trim($('#userId').val());
		pageinfo["job"] = $.trim($('#job').val());
		pageinfo["company"] = $.trim($('#company').val());
		pageinfo["phone"] = $.trim($('#phone').val());
		pageinfo["name"] = $.trim($('#contactsName').val());
		pageinfo["business"] = $.trim($('#business').val());

		$
				.ajax({
					type : "post",
					url : '${ctx}/contacts!findGroupContactsList.action',
					dataType : 'json',
					data : pageinfo,
					success : function(msg, status) {
						if (msg.status == 200) {
							var array = [];
							rowData = msg.rows;
							for ( var i = 0; i < msg.rows.length; i++) {
								var data = msg.rows[i];
								array.push('<tr>');
								array
										.push('<td style="cursor:pointer;text-align:center;">');
								array.push('<input type="checkbox" name="checkbox-tr" value="' + data["contactsId"]+ '"/></td>');
								array.push('<td style="cursor:pointer;text-center;">');
								array.push('<a href="javascript:void(0)" style="text-align:center;" onclick="updateContactsInfo('
												+ data["contactsId"]
												+ ')" class="menu" >'
												+ data["contactsName"]
												+ '</a></td>');

								array.push('<td style="text-align:center;">'
										+ data["job"] + '</td>');
								array.push('<td style="text-align:left;">'
										+ data["company"] + '</td>');

								
								array.push('<td>' + data["address"] + '</td>');
								
								array.push('<td style="text-align:center;">' + data["userName"] + '</td>');
								array
										.push('<td>' + data["groupName"]
												+ '</td>');

								array.push('</tr>');
							}
							$('#table_content').html(array.join(''));
							initpageInfo(msg.total);
						} else {
							alert(msg.msg);

						}
					}
				});
	}

	function deleteData() {
		var ids = [];
		$('input[name="checkbox-tr"]:checked').each(function(index, data) {
			ids.push($(this).val());
		});
		if (ids.length == 0) {
			alert('请选择数据!');
			return;
		} else {
			if (window.confirm('确定删除吗？')) {
				$.ajax({
					type : "post",
					url : '${ctx}/user!deleteAllData.action',
					dataType : 'json',
					data : {
						table : "contacts",
						fields : ids.join(',')
					},
					success : function(msg, status) {
						if (msg.status == 200) {
							alert('删除成功!');
							loadData(1);
						} else {
							alert(msg.msg);
						}
					}
				});
			}
		}

	}

	function updateContactsInfo(contactsId) {
		window.location.href = "${ctx}/contacts!findContactsInfo.action?contactsId="
				+ contactsId + '&userId=${param.userId}';
	}

	function conditionQuery() {
		document.getElementById('conditions').reset();
		openDialog('divBlack', 'divWhite');
	}

	function queryInfo() {
		closeDialog('divBlack', 'divWhite');
		loadData(1);
	}
</script>


