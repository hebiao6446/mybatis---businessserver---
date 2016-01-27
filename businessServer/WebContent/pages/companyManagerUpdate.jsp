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
				<a href="#" class="current">企业信息维护</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">

								<div class="control-group">
									<label class="control-label">名称：</label>
									<div class="controls">
										<input type="text" id="name" name="name" placeholder="请输入名称"
											value="${companyInfo.name}" style="width: 650px;" /> <span
											style="color: red">*必填项</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">联系人：</label>
									<div class="controls">
										<input type="text" id="linkman" name="linkman"
											placeholder="请输入联系人" value="${companyInfo.linkman}"
											style="width: 650px;" />
									</div>
								</div>
								<c:if test="${empty companyInfo.name}">
									<div class="control-group">
										<label class="control-label">默认管理员账号：</label>
										<div class="controls">
											<input type="text" id="account" name="account"
												placeholder="请输入管理员账号" style="width: 650px;"
												onblur="findAccout('account')" /> <span style="color: red"
												class="onblurs"></span>
										</div>
									</div>
								</c:if>

								<div class="control-group">
									<label class="control-label">介绍：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="introduce" name="introduce"
											placeholder="请输入介绍" value="${companyInfo.introduce}"
											style="width: 650px;" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">手机：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="phone" name="phone" placeholder="请输入手机"
											value="${companyInfo.phone}" style="width: 650px;"
											onblur="findAccout('phone')" /> <span style="color: red"
											class="onblurs"></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">地址：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="address" name="address"
											placeholder="请输入地址" value="${companyInfo.address}"
											style="width: 650px;" /> <span>
									</div>
								</div>


								<div class="control-group">
									<label class="control-label">邮箱：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="email" name="email" placeholder="请输入邮箱"
											value="${companyInfo.email}" style="width: 650px;" />
									</div>
								</div>


								<div class="control-group">
									<label class="control-label">上班时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="reportWork" name="reportWork"
											placeholder="请输入上班时间" value="${companyInfo.reportWork}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'HH:dd:ss'})"
											style="width: 650px;" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">下班时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="outWork" name="outWork"
											placeholder="请输入下班时间" value="${companyInfo.outWork}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'HH:dd:ss'})"
											style="width: 650px;" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">启用时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="enableTime" name="enableTime"
											placeholder="请输入启用时间" value="${companyInfo.enableTime}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
											style="width: 650px;" />
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">截至时间：</label>
									<div class="controls"
										style="padding-left: 0px; padding-right: 0px;">
										<input type="text" id="disableTime" name="disableTime"
											placeholder="请输入启用时间" value="${companyInfo.disableTime}"
											class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
											style="width: 650px;" />
									</div>
								</div>





								<div class="form-actions" style="padding-left: 200px;">

									<span class="btn btn-warning" onclick="saveCompanyInfo()">保&nbsp;&nbsp;存</span>
									<span class="btn btn-warning" style="margin-left: 100px;"
										onclick="javascript:history.go(-1);">返&nbsp;&nbsp;回</span>
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
	$(function() {
		//data:size:  0视频，1企业图片，2店铺图片，3商品图片，4其他
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

	function saveCompanyInfo() {
		if ($.trim($('#name').val()).length == 0) {
			$('#name_check').html('名称不为空！');
			return;
		}
		var b=false;
		$('#formInfo').find('.onblurs').each(function(){
			if($(this).html()!=''){
				alert($(this).html());
				b=true;
			}			
		});
		if(b){
			return;
		}

		var param = {};
		if ($.trim("${companyInfo.companyId}") != '') {
			param["companyId"] = "${companyInfo.companyId}";
		}

		param["name"] = $.trim($('#name').val());

		param["reportWork"] = $.trim($('#reportWork').val());
		param["outWork"] = $.trim($('#outWork').val());
		param["disableTime"] = $.trim($('#disableTime').val());
		param["enableTime"] = $.trim($('#enableTime').val());
		param["address"] = $.trim($('#address').val());
		param["email"] = $.trim($('#email').val());
		param["introduce"] = $.trim($('#introduce').val());
		param["phone"] = $.trim($('#phone').val());
		param["linkman"] = $.trim($('#linkman').val());
		param["account"] = $.trim($('#account').val());

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

	function findAccout(title) {

		if ($.trim($('#' + title).val()) == '') {
			$('#'+title).parent().find('span').html('不能为空!');
			return;
		}

		$.ajax({
			type : "post",
			url : '${ctx}/user!findUserAccountInfo.action',
			dataType : 'json',
			data : {
				username : title,
				password : $('#' + title).val()
			},
			success : function(msg, status) {
				if (msg.status == 200) {
					$('#'+title).parent().find('span').html('');
				} else {
					$('#'+title).parent().find('span').html(msg.msg);
					alert(msg.msg);
				}
			}
		});
	}
</script>


