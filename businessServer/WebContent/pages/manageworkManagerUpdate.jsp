<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户管理</title>

</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">考勤时间状态设置</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">

								<div class="control-group">
									<label class="control-label">上班时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="reportWork" name="reportWork"
											placeholder="请输入上班时间" value="${companyInfo.reportWork}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'HH:mm'})"
											style="width: 150px;" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">下班时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="outWork" name="outWork"
											placeholder="请输入下班时间" value="${companyInfo.outWork}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'HH:mm'})"
											style="width: 150px;" />
									</div>
								</div>


								<div class="control-group">
									<label class="control-label">上班时间是否定位员工：</label>

		                         <div class="controls">
                                  <label>
                                    <input name="wordTimeIsKown" id="wordTimeIsKownYes"  type="radio" name="radios" />
                                                                                                                               是</label>
                                     <label>
                                     <input name="wordTimeIsKown" id="wordTimeIsKownNo" type="radio" name="radios" />
                                                                                                                       否</label>
                                 <label>
                                 </div>
								</div>


								<div class="control-group">
									<label class="control-label">是否打开GPRS：</label>
                                   <div class="controls">
                                  <label>
                                    <input name="IsOpenGps" id="IsOpenGpsYes"  type="radio" name="radios" />
                                                                                                                               是</label>
                                     <label>
                                     <input name="IsOpenGps" id="IsOpenGpsNo" type="radio" name="radios" />
                                                                                                                       否</label>
                                 <label>
                                 </div>
								</div>


								<div class="form-actions" style="padding-left: 200px;">

									<span class="btn btn-warning" onclick="saveCompanyInfo()">保&nbsp;&nbsp;存</span>
					 
								</div>


							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/common/buttom.jsp"></jsp:include>
	<script type="text/javascript"
		src="${ctx}/js/My97DatePicker/WdatePicker.js"></script>
		
		
</body>
</html>
<script type="text/javascript">
/*
 * 默认调用
 */
	$(function() {
		new window.AjaxUpload($('#uploadImg'),
				{
					action : '${ctx}/company!uploadProductImage.action',
					name : 'uploadFile',
					data : {
						size : 1
					},
					responseType : 'json',
					onSubmit : function(file, ext) {
						if (ext != 'png' && ext != 'PNG' && ext != 'jpg'
								&& ext != 'JPG' && ext != 'jpeg'
								&& ext != 'JPEG') {
							alert('请选择png,jpg,jpeg文件类型！');
							return false;
						}
					},
					onComplete : function(file, response) {
						if (response.status == 200) {
							$('#companyImg').attr('src',
									'${http_img}' + response.rows);
							$('#ImgUrl').val(response.rows);
						} else {
							alert(response.msg);
						}
					}
				});
	});
	/*
	 * 保存
	 */
	function saveCompanyInfo() {
		if ($.trim($('#reportWork').val()).length == 0) {
			$('#name_check').html('上班时间不能为空');
			return;
		}
		
		if ($.trim($('#outtWork').val()).length == 0) {
			$('#name_check').html('下班时间不能为空');
			return;
		}
 
		var param = {};
		if ($.trim("${companyInfo.companyId}") != '') {
			param["companyId"] = "${companyInfo.companyId}";
		}

		param["name"] = $.trim($('#name').val());
 
		$.ajax({
			type : "post",
			url : '${ctx}/company!updateCompanyInfo.action',
			dataType : 'json',
			data : param,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功!');
					history.go(-1);
				} else {
					alert(msg.msg);

				}
			}
		});
	}

 
</script>


