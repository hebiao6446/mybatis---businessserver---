<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>考勤说明管理</title>
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

				<a href="#" class="current">考勤说明管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div style="padding: 10px 0 0 0;">
				<table style="width: 100%; font-size: 14px; font-weight: bold;">
					<tr valign="middle" align="right">
						<td width="80px">关键字搜索</td>
						<td width="100px"><input id="title" type="text" value=""
							style="margin-top: 8px; width: 200px;" /></td>
						<td align="left"><button class="btn btn-success"
								onclick="loadData(1)" style="font-size: 14px; cursor: pointer;">查询</button>
						</td>
					</tr>
				</table>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>说明列表</h5>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="5%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="65%" style="font-size: 12px;">说明内容</th>
									<th width="35%" style="font-size: 12px;">日期</th>
								</tr>
							</thead>
							<tbody id="table_content">
							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/common/buttom.jsp"></jsp:include>

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
		pageinfo["userId"] = '${param.userId}';

		$
				.ajax({
					type : "post",
					url : '${ctx}/attendance!findAttendDescriptList.action',
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
										.push('<td style="text-align:center;"><input type="checkbox" name="checkbox-tr" value="' + data["groupId"]+ '"/></td>');

								array.push('<td>' + data["content"] + '</td>');
								array.push('<td>' + data["dayTime"] + '</td>');

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
</script>


