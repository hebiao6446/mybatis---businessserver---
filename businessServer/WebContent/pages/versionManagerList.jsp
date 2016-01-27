<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>推销版本管理</title>
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
	left: 30%;
	width: 40%;
	height: auto;
	width: 40%;
	height: auto;
	height: auto;
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

				<a href="#" class="current">推销版本管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>推送版本列表</h5>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="5%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="8%" style="font-size: 12px;">版本标题</th>
									<th width="8" style="font-size: 12px;">版本编号</th>
									<th width="8" style="font-size: 12px;">版本类型</th>
									<th width="48%" style="font-size: 12px;">更新内容</th>
									<th width="16%" style="font-size: 12px;">下载地址</th>
									<th width="7%" style="font-size: 12px;">修改</th>


								</tr>
							</thead>
							<tbody id="table_content">

							</tbody>
						</table>

						<div class="widget-title"
							style="height: 40px; border: 1px solid #ccc; padding-bottom: 4px; padding-left: 20px;">

							<div class="pagination alternate"
								style="margin-left: 0px; margin-top: 8px; float: left;"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>



	<jsp:include page="/common/buttom.jsp"></jsp:include>

	<div id="divBlack" class="black_overlay"></div>
	<div id="divWhite" class="white_content">
		<input type="hidden" id="versionId" />
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 505px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i> </span>
					<h5 id="title">版本信息修改</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">

							<div class="controls" style="margin-left: 10px;">
								版本编号： <input type="text" name="urlNum" id="urlNum" size="130"
									style="width: 350px;" /><br />

							</div>
							<div class="controls" style="margin-left: 10px;">
								下载地址： <input type="text" name="urlpath" id="urlpath" size="130"
									style="width: 350px;" /><br />

							</div>
							<label class="control-label" style="width: 80px;">更新内容：</label>
							<div class="controls" style="margin-left: 10px;">
								<textarea name="content" id="versioncontent"
									style="width: 350px; height: 200px;"></textarea>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 20px;"
								onclick="updateVersionInfo()">保存</a> <a class="btn btn-success"
								style="margin: 0 20px;" onclick="closeDialog()">取消</a>
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
					url : '${ctx}/user!findVersionList.action',
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
										.push('<td style="cursor:pointer;text-align:center;"><input type="checkbox" name="checkbox-tr" value="' + data["versionId"]+ '"/></td>');

								array.push('<td>' + data["title"] + '</td>');
								array.push('<td>' + data["urlNum"] + '</td>');
								if (data["type"] == 1) {
									array
											.push('<td style="text-align:center;">安卓</td>');
								} else if (data["type"] == 2) {
									array
											.push('<td style="text-align:center;">ios</td>');
								} else {
									array.push('<td></td>');
								}
								array.push('<td>' + data["content"] + '</td>');
								array.push('<td>' + data["urlpath"] + '</td>');
								array
										.push('<td><a href="javascript:void(0)" onclick="openDialog('
												+ i + ');">修改</a></td>');

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

	function closeDialog() {
		document.getElementById('divWhite').style.display = 'none';
		document.getElementById('divBlack').style.display = 'none';
	}
	function openDialog(index) {
		document.getElementById('divWhite').style.display = 'block';
		document.getElementById('divBlack').style.display = 'block';
		$('#versioncontent').val(rowData[index]["content"]);
		$('#versionId').val(rowData[index]["versionId"]);
		$('#urlpath').val(rowData[index]["urlpath"]);
		$('#urlNum').val(rowData[index]["urlNum"]);
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
						table : "version",
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

	function updateVersionInfo() {

		var param = {
			versionId : $('#versionId').val()
		};
		param["content"] = $.trim($('#versioncontent').val());
		param["urlNum"] = $.trim($('#urlNum').val());
		param["urlpath"] = $.trim($('#urlpath').val());

		$.ajax({
			type : "post",
			url : '${ctx}/user!updateVersionInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					closeDialog();
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

