<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户管理</title>
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
				<a href="#" class="current">用户管理</a>
			</div>
		</div>
		<div class="container-fluid">
			<div style="padding: 10px 0 0 0;">
				<table style="width: 100%; font-size: 14px; font-weight: bold;">

					<tr valign="middle" align="right">

						<td width="80px">关键字搜索</td>
						<td width="100px"><input id="name" type="text" value=""
							style="margin-top: 8px; width: 200px;" />
						</td>
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
							<span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>用户列表</h5>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="10%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" />
									</th>
									<th width="15%" style="font-size: 12px;">用户帐号</th>
									<th width="15%" style="font-size: 12px;">真实姓名</th>
									<th width="20%" style="font-size: 12px;">联系方式</th>
									<th width="20%" style="font-size: 12px;">是否考勤</th>
									<th width="20%" style="font-size: 12px;">时间</th>
								</tr>
							</thead>
							<tbody id="table_content">
							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
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

		pageinfo["roleId"] = '${param.roleId}';

		$
				.ajax({
					type : "post",
					url : '${ctx}/role!findUserRoleList.action',
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
												+ data["account"] + '</td>');

								array.push('<td style="text-align:center;">'
										+ data["name"] + '</td>');
								array.push('<td style="text-align:center;">'
										+ data["phone"] + '</td>');

								if (data["attendance"] == 'T') {
									array.push('<td>是</td>');
								}
								if (data["attendance"] == 'F') {
									array.push('<td>否</td>');
								}

								array.push('<td style="text-align:center;">'
										+ data["updateTime"] + '</td>');

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
						table : "user",
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
				+ contactsId;
	}
</script>
</body>
</html>

