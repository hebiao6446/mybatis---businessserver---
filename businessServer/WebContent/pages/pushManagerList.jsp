<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>推送消息管理</title>
<style type="text/css">
.white_content {
	display: none;
	position: fixed;
	top: 20%;
	left: 30%;
	width: 40%;
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
</style>


</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">

				<a href="#" class="current">推送消息管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>推送消息列表</h5>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="5%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="60%" style="font-size: 12px;">推送内容</th>
									<th width="20%" style="font-size: 12px;">推送时间</th>
									<th width="10" style="font-size: 12px;">推送类别</th>

								</tr>
							</thead>
							<tbody id="table_content">

							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
						<div class="widget-title"
							style="height: 40px; border: 1px solid #ccc; padding-bottom: 4px; padding-left: 20px;">


							<div class="widget-title"
								style="height: 40px; border: 1px solid #ccc; padding-bottom: 4px; padding-left: 20px;">
								<button class="btn btn-warning" onclick="insertDialog();">推送消息</button>
								&nbsp;&nbsp; <a class="btn btn-warning"
									style="margin: 8px 10px 5px 10px;" onclick="deleteData();">删&nbsp;&nbsp;&nbsp;&nbsp;除</a>
								<div class="pagination alternate"
									style="margin-left: 0px; margin-top: 8px; float: left;"></div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/buttom.jsp"></jsp:include>

	<div id="divBlack" class="black_overlay"></div>
	<div id="divinsertWhite" class="white_content">
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 505px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i> </span>
					<h5 id="title">推送消息</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 100px;">推送消息：</label>
							<div class="controls" style="margin-left: 10px;">
								<textarea name="content" id="contentt"
									style="width: 350px; height: 150px;"></textarea>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 20px;"
								onclick="savePushInfo()">保存</a> <a class="btn btn-success"
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

		loadData(1);

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

		$
				.ajax({
					type : "post",
					url : '${ctx}/user!findPushList.action',
					dataType : 'json',
					data : pageinfo,
					success : function(msg, status) {
						var array = [];
						if (msg.status == 200) {
							rowData = msg.rows;
							for ( var i = 0; i < msg.rows.length; i++) {
								var data = msg.rows[i];
								array.push('<tr>');
								array.push('<td style="cursor:pointer;text-align:center;"><input type="checkbox" name="checkbox-tr" value="' + data["pushId"]+ '"/></td>');
								array.push('<td>' + data["content"] + '</td>');
								array.push('<td>' + data["updateTime"]
										+ '</td>');
								if (data["type"] == 1) {
									array
											.push('<td style="text-align:center;">推送消息</td>');
								} else if (data["type"] == 2) {
									array
											.push('<td style="text-align:center;">版本消息</td>');
								} else {
									array.push('<td></td>');
								}
								array.push('</tr>');
							}
							$('#table_content').html(array.join(''));
							array = null;
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
						table : "push",
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

	function closeinsertDialog() {
		document.getElementById('divinsertWhite').style.display = 'none';
		document.getElementById('divBlack').style.display = 'none';
	}
	function insertDialog() {
		document.getElementById('divinsertWhite').style.display = 'block';
		document.getElementById('divBlack').style.display = 'block';

	}

	function savePushInfo() {
		var param = {};
		param["content"] = $.trim($('#contentt').val());

		$.ajax({
			type : "post",
			url : '${ctx}/user!insertPushInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					closeinsertDialog();
					loadData(1);

				} else {
					alert(msg.msg);

				}
			}
		});
	}
</script>
</body>
</html>

