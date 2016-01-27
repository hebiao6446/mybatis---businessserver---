<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<%
	String strDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new Date());
	request.setAttribute("strDate", strDate);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>考勤统计</title>
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

#table_content td {
	text-align: center;
}
</style>
</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">下属考勤统计管理</a>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">

				<div class="span12" 
					style="font-size: 14px; font-weight: bold; margin-bottom: 20px;">
					开始时间:<input id="endTime" class="Wdate" style="width: 120px;"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> 结束时间:<input
						id="startTime" class="Wdate" style="width: 120px;"
						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startTime\');}',dateFmt:'yyyy-MM-dd'})" />
					<input name="authority" type="checkbox" id="authority1" value="A" />加入周六
					<input name="authority" type="checkbox" id="authority1" value="B" />加入周日
					<button class="btn btn-warning" type="button"
						class="btn btn-success" onclick="loadData(1)">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
					<button class="btn btn-warning" type="button"
						class="btn btn-success" onclick="loadData(1)">导&nbsp;&nbsp;&nbsp;&nbsp;出</button>
				</div>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-info-sign"></i> </span>
						<h5>下属人员考勤统计列表</h5>
					</div>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th width="3%"></th>
								<th width="10%">签到人姓名</th>
								<th width="10%">迟到</th>
								<th width="10%">早退</th>
								<th width="10%">未签到</th>
								<th width="10%">未签退</th>
								<th width="10%">历史考勤</th>
								<th width="10%">地图查询</th>
							</tr>
						</thead>
						<tbody id="table_content">
						</tbody>
					</table>
					<div class="widget-title"
						style="height: 40px; border: 1px solid #ccc; padding: 20px;">

						<a class="btn btn-warning" style="margin-right: 20px;"
							onclick="insertAttendDesc()">签到/签退情况说明</a>
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
			<div class="widget-box" style="width: 365px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i> </span>
					<h5 id="title">签到/签退情况说明</h5>
				</div>
				<div class="widget-content nopadding"> 
					<form class="form-horizontal">
						<div class="control-group">
							<label class="control-label" style="width: 100px;">信息内容：</label>
							<div class="controls" style="margin-left: 10px;">
								<textarea type="text" name="attendDescript" id="attendDescript"
									style="width: 200px; margin-left: 10px; background-color: #FFF;"></textarea>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 20px;"
								onclick="saveInfo()">保存</a> <a class="btn btn-success"
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
	$(function() {
		loadData();
	});

	function insertAttendDesc() {
		$('#content').val('');
		$('#divWhite').css({
			display : 'block'
		});
		$('#divBlack').css({
			display : 'block'
		});
	}
	function saveInfo() {
		$.ajax({
			type : "post",
			url : '${ctx}/attendance!saveAttendDescInfo.action',
			dataType : 'json',
			data : {
				content : $('#attendDescript').val()
			},
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功！');
					closeDialog();
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

	function updateAttendance(type) {
		$.ajax({
			type : "post",
			url : '${ctx}/attendance!updateAttendance.action',
			dataType : 'json',
			data : {
				signType : type
			},
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('签到/签退成功！');
					window.location.reload();
				} else {
					alert(msg.msg);
				}
			}
		});
	}

	function loadData() {
		$.ajax({
			type : "post",
			url : '${ctx}/attendance!findSubUserAttendanceList.action',
			dataType : 'json',
			data : {
				dayTime : $('#dayTime').val()
			},
			success : function(msg, status) {
				if (msg.status == 200) {
					var array = [];
					for ( var i = 0; i < msg.rows.length; i++) {
						var data = msg.rows[i];
						array.push('<tr>');
						array.push('<td>' + data["userId"] + '</td>');
						array.push('<td>' + "张兴旺" + '</td>');
						array.push('<td>' + 2 + '</td>');
						array.push('<td>' + 5 + '</td>');
						array.push('<td>' + 3 + '</td>');
						array.push('<td>' + 2 + '</td>');
						array.push('<td>' + "进入详情" + '</td>');
						array.push('<td>' + "查看地图" + '</td>');

					}

					array.push('</tr>');
				}
				$('#table_content').html(array.join(''));

			}
		});
	}

	function queryattendance(userId) {
		window.location.href = "${ctx}/pages/attendanceManagerList.jsp?userId="
				+ userId;
	}
	function query(userId) {
		window.location.href = "${ctx}/pages/attendacedescriptManagerList.jsp?userId="
				+ userId;
	}
	function queryData() {
		var str = $.trim($('#dayTime').val());
		var date;
		if (str == '' || str.length == 0) {
			date = new Date();
		} else {
			date = new Date(Date.parse(str));
		}
		if (date.getTime() > (new Date().getTime())) {
			date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var str1 = year + '-' + (month < 10 ? '0' + month : month) + '-'
					+ (day < 10 ? '0' + day : day);
			$('#dayTime').val(str1);
		}
		loadData();
	}

	function updateAttendTime(add) {
		var str = $.trim($('#dayTime').val());
		var date;
		if (str == '' || str.length == 0) {
			date = new Date();
		} else {
			date = new Date(Date.parse(str));
		}
		date.setDate(date.getDate() + add);
		if (date.getTime() > (new Date().getTime())) {
			date = new Date();
		}
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		var str1 = year + '-' + (month < 10 ? '0' + month : month) + '-'
				+ (day < 10 ? '0' + day : day);
		$('#dayTime').val(str1);
		loadData();
	}
</script>


