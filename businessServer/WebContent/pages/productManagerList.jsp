<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>商品管理</title>
<style type="text/css">
.condition {
	float: right;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	padding: 4px 10px;
}

.input_cla {
	color: red;
	width: 150px;
	border: 2px;
	padding: 2px 5px;
}

.me_text {
	font-size: 16px;
}

.me_top {
	padding: 5px 10px;
	cursor: pointer;
	position: relative;
	margin: 2px;
	font-weight: bold;
	background: ;
}

.me_dow {
	display: none;
}

.me_dow a {
	margin: 2px 0 2px 0px;
	display: block;
	background-color: #EFEFEF;
	padding: 5px 0 5px 20px;
	font-weight: bold;
	text-decoration: none;
	display: block;
}

.me_dow a:hover {
	color: #000000;
	text-decoration: blink;
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

				<a href="${ctx}/pages/index.jsp?menue="> <i class="icon-home"></i>首页
				</a> <a href="javascript:void(0)" class="current">商品列表</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span3">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>商品分类</h5>
						</div>
						<div class="widget-content nopadding">
							<div id="me_list" class="me_text"></div>
						</div>
					</div>
				</div>
				<div class="span9">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>商品维护</h5>
							<span class="condition"> <input class="input_cla"
								placeholder="商品名称/介绍" id="productName" value=""> <a
								class="btn btn-mini btn-info" onclick="loadData()">查询</a></span>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th width="5%"><input type="checkbox"
											id="title-table-checkbox" name="title-table-checkbox" /></th>
										<th width="20%">商品名称</th>
										<th width="60%">商品介绍</th>
										<th width="15%">商品价格</th>
									</tr>
								</thead>
								<tbody id="table_content"></tbody>
							</table>
							<jsp:include page="/common/pagenation.jsp"></jsp:include>
							<div class="widget-title"
								style="height: 40px; border: 1px solid #ccc; padding: 20px;">
								<a class="btn btn-warning" style="margin: 0 10px;"
									onclick="window.location.href='${ctx}/product!findProductInfo.action'">新&nbsp;&nbsp;&nbsp;&nbsp;增</a>
								<a class="btn btn-warning" style="margin: 0 10px;"
									onclick="deleteProductData()">删&nbsp;&nbsp;&nbsp;&nbsp;除</a>
							</div>
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
	var categoryId = '';

	$(function() {
		$
				.ajax({
					type : 'post',
					url : '${ctx}/product!findProductCategory.action',
					dataType : 'json',
					data : {},
					success : function(msg) {
						if (msg.status == 200) {
							var array = [ '<p class="me_top" categoryId="">全部商品</p>' ];
							for ( var i = 0; i < msg.rows.length; i++) {
								var data = msg.rows[i];
								array
										.push('<p class="me_top" categoryId="'+data["productCategoryId"]+'">'
												+ data["name"] + '</p>');
								if (data["list"] != null
										&& data["list"].length > 0) {
									array.push('<div class="me_dow">');
									for ( var j = 0; j < data["list"].length; j++) {
										array
												.push('<a class="cas" categoryId="'
														+ data["list"][j]["productCategoryId"]
														+ '">'
														+ data["list"][j]["name"]
														+ '</a>');
									}
									array.push('</div>');
								}
							}
							$('#me_list').html(array.join(''));
							$("#me_list p.me_top").click(function() {
								$(this).siblings("div.me_dow").slideUp("slow");
								$(this).next("div.me_dow").slideToggle(300);
								categoryId = $(this).attr('categoryId');
								loadData(1);
							});
							$("#me_list div.me_dow a.cas").click(function() {
								categoryId = $(this).attr('categoryId');
								loadData(1);
							});
						} else {
							alert(msg.msg);
						}
					}
				});
		loadData();
	});

	function loadData(page, size) {
		setpageinfo(page, size);
		pageinfo["categoryId"] = categoryId;
		pageinfo["productName"] = $('#productName').val();
		$
				.ajax({
					type : 'post',
					url : '${ctx}/product!findProductList.action',
					dataType : 'json',
					data : pageinfo,
					success : function(msg) {
						if (msg.status == 200) {
							var array = [];
							for ( var i = 0; i < msg.rows.length; i++) {
								var data = msg.rows[i];
								array.push('<tr>');
								array
										.push('<td style="text-align:center;">'
												+ '<input type="checkbox" '
								+ 'name="checkbox-tr" value="' 
								+ data["productId"]+ '"/></td>');
								array
										.push('<td style="text-align:center;cursor:pointer;">'
												+ '<span onclick="updateproductInfo('
												+ data["productId"]
												+ ')" class="menu">'
												+ data["productName"]
												+ '</span></td>');
								var content=data["content"];
								if(content.length>35){
									content=content.substring(0,35)+'...';
								}
								array.push('<td>' + content + '</td>');
								array.push('<td>' + data["price"] + '</td>');
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

	function updateproductInfo(productId) {
		window.location.href = '${ctx}/product!findProductInfo.action?productId='
				+ productId;
	}

	function deleteProductData() {
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
				url : '${ctx}/product!deleteProductData.action',
				dataType : 'json',
				data : {productId:array.join(',')},
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


