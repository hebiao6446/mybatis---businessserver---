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
	top: 30%;
	left: 30%;
	width: 405px;
	height: 245px;
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
</style>


</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">联系人分组管理</a>
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
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="10%">分组编号</th>
									<th width="40%">分组名称</th>
									<th width="15%">更新时间</th>
									<th width="15%">是否默认</th>
									<th width="20%">修改/更新</th>
								</tr>
							</thead>
							<tbody id="table_content">
							</tbody>
						</table>

						<div class="widget-title"
							style="height: 60px; border: 1px solid #ccc; padding: 20px 100px;">
							<button class="btn btn-warning" onclick="insertDialog();">新&nbsp;&nbsp;&nbsp;&nbsp;增</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/buttom.jsp"></jsp:include>

	<div id="divBlack" class="black_overlay"></div>
	<div id="divWhite" class="white_content">
		<input type="hidden" id="groupId" />
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 365px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i>
					</span>
					<h5 id="title">分组名称修改</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 100px;">名称：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" name="name" id="name" size="130"
									style="width: 200px;" /><br /> <span><font color="red"
									id="serialName_check"></font></span>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 20px;"
								onclick="updateGroupInfo()">保存</a> <a class="btn btn-success"
								style="margin: 0 20px;" onclick="closeDialog()">取消</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<div id="divinsertWhite" class="white_content">
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 365px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i>
					</span>
					<h5 id="title">分组名称新增</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 100px;">名称：</label>
							<div class="controls" style="margin-left: 10px;">
								<input type="text" id="namee" size="130" style="width: 200px;" /><br />
								<span><font color="red" id="serialName_check"></font></span>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 20px;"
								onclick="saveGroupInfo()">保存</a> <a class="btn btn-success"
								style="margin: 0 20px;" onclick="closeinsertDialog()">取消</a>
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
			url : '${ctx}/contacts!findGroupList.action',
			dataType : 'json',
			data : pageinfo,
			success : function(msg, status) {
				var array = [];
				if (msg.status == 200) {
					rowData = msg.rows;
					for ( var i = 0; i < msg.rows.length; i++) {
						var data = msg.rows[i];
						array.push('<tr><td style="text-align:center;">'
									+ data["groupId"] + '</td>');
						array.push('<td style="text-align:center;">'+data["name"] + '</td>');
						array.push('<td style="text-align:center;">' + data["updateTime"] + '</td>');
						if(data["isDefault"]=='T'){
							array.push('<td style="text-align:center;">默认分组</td>');
						}else{
							array.push('<td></td>');
						}
						array.push('<td style="cursor:pointer;text-align:center;">');
						array.push('<a href="javascript:void(0)" onclick="openDialog('
										+ i + ');">修改</a>');
						if(data["isDefault"]=='T'){
						}else{
							array.push('<a href="javascript:void(0)" style="margin-left:30px;" ');
							array.push(' onclick="deleteData(' + data["groupId"]+ ');">删除</a>');
						}						
						array.push('</td></tr>');
					}
					$('#table_content').html(array.join(''));
				} else {
					alert(msg.msg);
				}
			}
		});
	});

	function deleteData(groupId) {		
		if (window.confirm('确定删除吗？')) {
			$.ajax({
				type : "post",
				url : '${ctx}/contacts!updateGroupInfo.action',
				dataType : 'json',
				data : {groupId : groupId,type : 3},
				success : function(msg, status) {
					if (msg.status == 200) {
						alert('删除成功!');
						window.location.reload();
					} else {
						alert(msg.msg);
					}
				}
			});
		}
	}

	function closeDialog() {
		document.getElementById('divWhite').style.display = 'none';
		document.getElementById('divBlack').style.display = 'none';
	}
	function openDialog(index) {
		document.getElementById('divWhite').style.display = 'block';
		document.getElementById('divBlack').style.display = 'block';
		$('#name').val(rowData[index]["name"]);
		$('#groupId').val(rowData[index]["groupId"]);
	}

	function closeinsertDialog() {
		document.getElementById('divinsertWhite').style.display = 'none';
		document.getElementById('divBlack').style.display = 'none';
	}
	function insertDialog() {
		document.getElementById('divinsertWhite').style.display = 'block';
		document.getElementById('divBlack').style.display = 'block';

	}
	function query(groupId) {

		window.location.href = "${ctx}/pages/contactsManagerList.jsp?groupId="
				+ groupId;
	}

	function saveGroupInfo() {
		var param = {};
		param["name"] = $.trim($('#namee').val());
		param["type"] = 1;

		$.ajax({
			type : "post",
			url : '${ctx}/contacts!updateGroupInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					closeDialog();
					closeinsertDialog();
					loadData(1);

				} else {
					alert(msg.msg);

				}
			}
		});
	}

	function updateGroupInfo() {
		var param = {groupId : $('#groupId').val()};		
		param["type"] = 2;
		param["name"] = $.trim($('#name').val());
		$.ajax({
			type : "post",
			url : '${ctx}/contacts!updateGroupInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					closeDialog();
					closeinsertDialog();
					loadData(1);
				} else {
					alert(msg.msg);
				}
			}
		});
	}
</script>


