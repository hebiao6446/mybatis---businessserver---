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
							<h5>下属人员列表</h5>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="10%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="35%" style="font-size: 12px;">姓名</th>
									<th width="35%" style="font-size: 12px;">查看分组</th>


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

</body>
</html>
<script type="text/javascript">
	var rowData = [];
	$(function() {

		loadData(1);

	});
	function loadData(page, size) {
	

		$
				.ajax({
					type : "post",
					url : '${ctx}/contacts!findMySubContactsList.action',
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
										.push('<td style="cursor:pointer;text-align:center;"><input type="checkbox" name="checkbox-tr" value="' + data["userId"]+ '"/></td>');
								array
										.push('<td style="cursor:pointer;text-align:center;">'
												+ data["name"] + '</td>');
								array
										.push('<td><a href="javascript:void(0)" onclick="query('
												+ data["userId"]
												+ ')">查看分组</a></td>');
								array.push('</tr>');
							}
							$('#table_content').html(array.join(''));
							array = null;
							

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
						table : "group",
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

	function query(userId) {

		window.location.href = "${ctx}/pages/groupManagerList.jsp?userId="
				+ userId;
	}
</script>
</body>
</html>

