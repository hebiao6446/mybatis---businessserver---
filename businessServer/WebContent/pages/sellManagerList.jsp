<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>销售管理</title>
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
</style>
</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">销售管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>销售列表</h5>
							<span class="condition" onclick="conditionQuery()">条件查询</span>
						</div>
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="2%"><input type="checkbox"
										id="title-table-checkbox" name="title-table-checkbox" /></th>
									<th width="20%" style="font-size: 12px;">联系人企业</th>
									<th width="10%" style="font-size: 12px;">联系人</th>
									<th width="10%" style="font-size: 12px;">销售员</th>
									<th width="10%" style="font-size: 12px;">来源</th>
									<th width="10%" style="font-size: 12px;">最近联系时间</th>
									<th width="8%" style="font-size: 12px;">状态</th>
									<th width="10%" style="font-size: 12px;">费用总计</th>
									<th width="10%" style="font-size: 12px;">拜访详情</th>
								</tr>
							</thead>
							<tbody id="table_content">
							</tbody>
						</table>
						<jsp:include page="/common/pagenation.jsp"></jsp:include>
						<div class="widget-title"
							style="height: 40px; border: 1px solid #ccc; padding: 20px;">
							<a class="btn btn-warning" style="margin: 0 10px;" onclick="insertData('')">新&nbsp;&nbsp;&nbsp;&nbsp;增</a>
							<a class="btn btn-warning" style="margin: 0 10px;" onclick="deleteSellData()">删&nbsp;&nbsp;&nbsp;&nbsp;除</a>
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
		setpageinfo(page, size);

		pageinfo["name"] = $.trim($('#name').val());
		pageinfo["linkman"] = $.trim($('#linkman').val());
		pageinfo["phone"] = $.trim($('#phone').val());
		pageinfo["startEnable"] = $.trim($('#startEnable').val());
		pageinfo["endEnable"] = $.trim($('#endEnable').val());
		pageinfo["startDisable"] = $.trim($('#startDisable').val());
		pageinfo["endDisable"] = $.trim($('#endDisable').val());

		$
				.ajax({
					type : "post",
					url : '${ctx}/sell!findUserSellList.action',
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
										.push('<td style="text-align:center;">'
												+ '<input type="checkbox" '
								+ 'name="checkbox-tr" value="' 
								+ data["sellId"]+ '"/></td>');
								array.push('<td>'
										+ '<span onclick="insertData('
										+ data["sellId"] + ')" class="menu" >'
										+ data["contactsCompany"]
										+ '</span></td>');
								array.push('<td style="text-align:center;">' + data["contactsName"]
										+ '</td>');
								array.push('<td style="text-align:center;">' + data["userName"] + '</td>');
								array.push('<td style="text-align:center;">'+data["sellMethod"]+'</td>');
								array.push('<td>'+data["updateTime"]+'</td>');
								if (data["status"] == 1) {
									array
											.push('<td style="text-align:center;">已成功</td>');
								} else if (data["status"] == 2) {
									array
											.push('<td style="text-align:center;">再谈中</td>');
								} else if (data["status"] == 3) {
									array
											.push('<td style="text-align:center;">已失败</td>');
								} else {
									array.push('<td>'+data["updateTime"]+'</td>');
								}
								array.push('<td style="text-align:center;">' + data["totalPrice"]
										+ '</td>');
								array.push('<td style="text-align:center;">进入</td>');

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
	
	
	
	function insertData(sellId){
		window.location.href="${ctx}/sell!findUserSellInfo.action?sellId="+sellId;		
	}
	function deleteSellData(){
		var array = [];
		$('#table_content').find('input[name="checkbox-tr"]:checked').each(
				function() {
					array.push($(this).val());
				});
		if (array.length == 0) {
			alert('请选择数据！');
			return;
		}
		if (confirm('你确定删除所选商品吗')) {
			$.ajax({
				type : 'post',
				url : '${ctx}/sell!deleteSellData.action',
				dataType : 'json',
				data : {sellIdList:array.join(',')},
				success : function(msg) {
					if (msg.status == 200) {
						alert('删除成功！');
						loadData();
					}else{
						alert(msg.msg);
					}
				}
			});
		}
	}
	
	
</script>


