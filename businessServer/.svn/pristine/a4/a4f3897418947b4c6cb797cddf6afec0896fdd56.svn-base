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

.productList {
	height: 400px;
	overflow: auto;
	border: 1px #CCC solid;
}

#ul_product {
	padding: 10px 20px;
	font-size: 14px;
}

#ul_product>li {
	padding: 5px 0;
	list-style: decimal;
}

.txtpan {
	width: 80px;
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
							<span class="icon"> <i class="icon-info-sign"></i> </span>
							<h5>销售</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">
								<div class="control-group">
									<label class="control-label">联系人(客户)：</label>
									<div class="controls">

										<select id="contactsId" name="contactsId" class="span4"
											<c:if
											test="${not empty sell.contactsId &&sell.contactsId!=''&&sell.contactsId!=0}">
											 disabled="disabled"
											</c:if>>
											<c:forEach items="${contactsList}" var="contacts">
												<option value="${contacts.contactsId}"
													<c:if test="${contacts.contactsId==sell.contactsId}">
												selected="selected"</c:if>>${contacts.contactsName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">来源：</label>
									<div class="controls">
										<input id="sellMethod" name="sellMethod" class="span4"
											value="${sell.sellMethod}">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">状态：</label>
									<div class="controls">
										<select id="status" name="status" class="span4">
											<option value="1"
												<c:if test="${sell.status==1}">
												selected="selected"</c:if>>已成功</option>
											<option value="2"
												<c:if test="${empty sell.status||sell.status==2||sell.status==''}">
												selected="selected"</c:if>>再谈中</option>
											<option value="3"
												<c:if test="${sell.status==3}">
												selected="selected"</c:if>>已失败</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">商品：</label>
									<div class="controls">
										<c:forEach items="${sellProductList}" var="sellProduct">
											<div style="margin-bottom: 10px;"
												productId="${sellProduct.productId}">
												<span style="width: 100px;">${sellProduct.productName}</span>
												&nbsp;&nbsp;单价：<input
													onblur="checkData(this,'${sellProduct.price}')"
													value="${sellProduct.price}" class="txtpan">元
												&nbsp;×&nbsp;数量：<input
													onblur="checkData(this,'${sellProduct.productNum}')"
													value="${sellProduct.productNum}" class="txtpan"><a
													style="cursor: pointer;" onclick="deleteThis(this)"><i
													class="icon-remove"></i>删除</a>
											</div>
										</c:forEach>
										<div id="addData">
											<a class="btn btn-warning" onclick="selectProduct()">添加商品</a>
											总价格：<span>${sell.totalPrice}</span>元
										</div>
									</div>
								</div>
								<div class="form-actions" style="padding-left: 200px;">
									<span class="btn btn-warning" onclick="saveSellInfo()">保&nbsp;&nbsp;存</span>
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

	<div id="divBlack" class="black_overlay"></div>
	<div id="divWhite" class="white_content">
		<div class="span4" style="margin: 0 16px;">
			<div class="widget-box" style="width: 365px;">
				<div class="widget-title">
					<span class="icon"> <i class="icon-align-justify"></i> </span>
					<h5 id="title">商品列表</h5>
				</div>
				<div class="widget-content nopadding">
					<form class="form-horizontal">
						<div class="control-group">
							<div class="productList">
								<ul id="ul_product">
									<c:forEach var="product" items="${productList}">
										<li class="li_product"
											<c:forEach items="${sellProductList}" var="sellProduct"><c:if test="${product.productId ==sellProduct.productId}">style="display:none;"</c:if></c:forEach>><input
											type="checkbox" value="${product.productId}" /><span
											name="productName">${product.productName}</span>&nbsp;&nbsp;单价：<span
											name="productPrice">${product.price}</span></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="form-actions">
							<a class="btn btn-success" style="margin: 0 30px;"
								onclick="addProduct()">确定</a> <a class="btn btn-success"
								style="margin: 0 30px;"
								onclick="closeDialog('divBlack','divWhite')">取消</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	var totalPrice = 0;
	function addProduct() {
		var array = [];
		$('#ul_product')
				.find('input[type="checkbox"]:checked')
				.each(
						function() {
							var $Obj = $(this).parents('li.li_product');
							$Obj.find('span.checked').attr('class', '');
							$(this).parents('li.li_product').hide();
							$(this).attr('checked', false);
							var productId = $(this).val();
							var productName = $Obj.find(
									'span[name="productName"]').html();
							var productPrice = $Obj.find(
									'span[name="productPrice"]').html();
							array
									.push('<div style="margin-bottom: 10px;" productId="'+productId+'">');
							array.push('<span style="width: 100px;">'
									+ productName + '</span>');
							array
									.push('&nbsp;&nbsp;单价：<input  onblur="checkData(this,'
											+ productPrice
											+ ')" value="'
											+ productPrice
											+ '" class="txtpan">元');
							array
									.push('&nbsp;×&nbsp;数量：<input onblur="checkData(this,1)" value="1" class="txtpan"><a style="cursor: pointer;" onclick="deleteThis(this)"><i class="icon-remove"></i>删除</a></div>');
						});
		$('#addData').before(array.join(''));
		totalprice();
		closeDialog('divBlack', 'divWhite');
	}

	function selectProduct() {
		openDialog('divBlack', 'divWhite');
	}
	function deleteThis(obj) {

		var productId = $(obj).parent().attr('productId');
		$('#ul_product').find('input[value="' + productId + '"]').parents(
				'li.li_product').show();
		$(obj).parent().remove();
		totalprice();
	}
	function totalprice() {
		totalPrice = 0;
		$('#addData').parents('div.controls').find('div[productId]').each(
				function() {
					var price = $(this).find('input').eq(0).val();
					var qty = $(this).find('input').eq(1).val();
					totalPrice += parseFloat(price) * parseInt(qty);
				});
		$('#addData').find('span').html(totalPrice);
	}
	function checkData(obj, num) {
		$.trim($(obj).val());
		if ($.trim($(obj).val()) == '' || $.trim($(obj).val()) == 0) {
			$(obj).val(1);
		} else if (isNaN($(obj).val())) {
			alert('数据错误！');
			$(obj).val(num);
		}
		totalprice();
	}
	function saveSellInfo() {
		var sell = {};
		sell["contactsId"] = $('#contactsId').val();
		sell["sellMethod"] = $('#sellMethod').val();
		sell["status"] = $('#status').val();
		sell["totalPrice"] = $('#addData').find('span').html();

		var sellProductList = [];
		$('#addData').parents('div.controls').find('div[productId]').each(
				function() {
					var sellProduct = {};
					sellProduct["price"] = $(this).find('input').eq(0).val();
					sellProduct["productNum"] = $(this).find('input').eq(1)
							.val();
					sellProduct["productId"] = $(this).attr('productId');
					sellProductList.push(sellProduct);
				});
		sell["sellProductList"] = JSON.stringify(sellProductList);
		$.ajax({
			type : "post",
			url : '${ctx}/sell!updateSellInfo.action',
			dataType : 'json',
			data : sell,
			success : function(msg, status) {
				if (msg.status == 200) {
					alert('保存成功！');
					window.history.go(-1);
				} else {
					alert(msg.msg);
				}
			}
		});
	}
</script>


