<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>企业帐号管理</title>
<style type="text/css">
.white_content {
	display: none;
	position: fixed;
	top: 20%;
	left: 35%;
	width: 30%;
	height: auto;
	border: 2px solid lightblue;
	background-color: #efefef;
	z-index: 1002;
	overflow: auto;
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
.dialogSelect{
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
				<a href="#" class="current">企业管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>分组列表</h5>
							<span class="condition" onclick="conditionQuery()">条件查询</span>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="2%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="10%" style="font-size: 12px;">用户帐号</th>
									<th width="10%" style="font-size: 12px;">真实姓名</th>
									<th width="10%" style="font-size: 12px;">联系方式</th>
									<th width="10%" style="font-size: 12px;">公司职务</th>
									<th width="20%" style="font-size: 12px;">所在公司</th>
									<th width="15%" style="font-size: 12px;">注册时间</th>
									<th width="15%" style="font-size: 12px;">最近使用时间</th>
									<th width="8%" style="font-size: 12px;">帐号状态</th>
								</tr>
							</thead>
							<tbody id="table_content">

							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
						<div class="widget-title"
							style="height: 40px; border: 1px solid #ccc; padding: 20px;">
							<a class="btn btn-warning" style="margin: 0 10px;"
								onclick="deleteUserAllData()">关&nbsp;&nbsp;&nbsp;&nbsp;闭</a>
							<a class="btn btn-warning" style="margin: 0 10px;"
								onclick="deleteUserQllData()">开&nbsp;&nbsp;&nbsp;&nbsp;启</a>
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
					<h5 id="title">查询条件:</h5>
				</div>
				<div class="widget-content nopadding">
					<form id="conditions" class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 110px;">公司名称：</label>
							<div class="controls" style="margin-left: 110px;">
								<select id="companyId" name="companyId" class="dialogSelect">
								<option value="" selected="selected">&nbsp;</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">昵称(姓名)：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="name" name="name" class="dialogInput" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" style="width: 110px;">手机号码：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="phone" name="phone" class="dialogInput" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">注册时间：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" class="Wdate dialogDate" id="startEnable"
									name="startEnable"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endEnable\');}',dateFmt:'yyyy-MM-dd'})" />
								&nbsp;--<input type="text" class="Wdate dialogDate"
									id="endEnable" name="endEnable"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startEnable\');}',dateFmt:'yyyy-MM-dd'})" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" style="width: 110px;">最后登录时间：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" class="Wdate dialogDate" id="startDisable"
									name="startDisable"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDisable\');}',dateFmt:'yyyy-MM-dd'})" />
								&nbsp;--<input type="text" class="Wdate dialogDate"
									id="endDisable" name="endDisable"
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDisable\');}',dateFmt:'yyyy-MM-dd'})" />
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
		$.ajax({
			type : "post",
			url : '${ctx}/company!findCompanyList.action',
			dataType : 'json',
			data : pageinfo,
			success : function(msg, status) {
				if (msg.status == 200) {
					var array=[];
					for(var i=0;i<msg.rows.length;i++){
						var data = msg.rows[i];
						array.push('<option value="'+data["companyId"]+'">'+data["name"]+'</option>');
					}
					$('#companyId').append(array.join(''));					
				}else{
					alert(msg.msg);
				}				
			}			
		});
		
		loadData(1);
	});
	function loadData(page, size) {
		setpageinfo(page, size);

		pageinfo["username"] = $.trim($('#name').val());
		pageinfo["phone"] = $.trim($('#phone').val());
		pageinfo["startEnable"] = $.trim($('#startEnable').val());
		pageinfo["endEnable"] = $.trim($('#endEnable').val());
		pageinfo["startDisable"] = $.trim($('#startDisable').val());
		pageinfo["endDisable"] = $.trim($('#endDisable').val());

		$
				.ajax({
					type : "post",
					url : '${ctx}/company!findCompanyAccountList.action',
					dataType : 'json',
					data : pageinfo,
					success : function(msg, status) {
						var array = [];
						if (msg.status == 200) {
							rowData = msg.rows;
							for ( var i = 0; i < msg.rows.length; i++) {
								var data = msg.rows[i];
								array.push('<tr>');

								array
										.push('<td style="cursor:pointer;text-align:center;">'
												+ '<input type="checkbox"  name="checkbox-tr" value="' + data["userId"]+ '"/></td>');
								array
										.push('<td style="cursor:pointer;text-align:center;">'
												+ data["account"] + '</td>');

								array.push('<td style="text-align:center;">'
										+ data["userName"] + '</td>');
								array.push('<td style="text-align:center;">'
										+ data["userPhone"] + '</td>');
								array.push('<td style="text-align:center;">'
										+ data["roleName"] + '</td>');
								array.push('<td>'
										+ data["companyName"] + '</td>');

								array.push('<td style="text-align:center;">'
										+ data["registerTime"] + '</td>');
								array.push('<td style="text-align:center;">'
										+ data["lastLogin"] + '</td>');
								if (data["status"] == 1) {
									array.push('<td style="text-align:center;">已开启</td>');
								} else if (data["status"] == 2) {
									array.push('<td style="text-align:center;">已关闭</td>');
								} else {
									array.push('<td></td>');
								}
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

	function conditionQuery() {
		document.getElementById('conditions').reset();
		openDialog('divBlack', 'divWhite');
	}

	function queryInfo() {
		closeDialog('divBlack', 'divWhite');
		loadData(1);
	}
	
	
	function deleteUserAllData() {
		var ids = [];
		$('input[name="checkbox-tr"]:checked').each(function(index, data) {
			ids.push($(this).val());
		});
		if (ids.length == 0) {
			alert('请选择数据!');
			return;
		} else {
			if (window.confirm('确定更改吗？')) {
				$.ajax({
					type : "post",
					url : '${ctx}/user!deleteUserAllData.action',
					dataType : 'json',
					data : {
						table : "user",
						fields : ids.join(',')
					},
					success : function(msg, status) {
						if (msg.status == 200) {
							alert('更改成功!');
							loadData();
						} else {
							alert(msg.msg);
						}
					}
				});
			}
		}
	}

	function deleteUserQllData() {
		var ids = [];
		$('input[name="checkbox-tr"]:checked').each(function(index, data) {
			ids.push($(this).val());
		});
		if (ids.length == 0) {
			alert('请选择数据!');
			return;
		} else {
			if (window.confirm('确定更改吗？')) {
				$.ajax({
					type : "post",
					url : '${ctx}/user!deleteUserQllData.action',
					dataType : 'json',
					data : {
						table : "user",
						fields : ids.join(',')
					},
					success : function(msg, status) {
						if (msg.status == 200) {
							alert('更改成功!');
							loadData();
						} else {
							alert(msg.msg);
						}
					}
				});
			}
		}
	}
</script>


