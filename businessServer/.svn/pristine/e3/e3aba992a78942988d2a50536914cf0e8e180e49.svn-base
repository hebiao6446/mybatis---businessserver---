<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>商品管理</title>
<style type="text/css">
.dialogInput {
	width: 320px;
	margin-left: 0px;
	background-color: #FFF;
}

.dialogDate {
	width: 90px;
	margin-left: 0px;
	background-color: #FFF;
}

.dialogSelect {
	width: 120px;
	margin-left: 10px;
	background-color: #FFF;
}

.dialogImg {
	max-width: 112px;
	max-height: 120px;
}

.dialogAmargin {
	margin: 0px 0 0 30px;
}

.dialogAmargin>a {
	font-size: 5px;
}

.dialogDivImg {
	width: 120px;
	height: 120px;
	float: left;
}
</style>
</head>
<body>

	<jsp:include page="/common/head.jsp"></jsp:include>
	<jsp:include page="/common/leftmenue.jsp"></jsp:include>
	<div id="content">
		<div id="content-header">
			<div id="breadcrumb">
				<a href="#" class="current">商品管理</a>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-info-sign"></i>
							</span>
							<h5>商品</h5>
						</div>
						<div class="widget-content nopadding">
							<form class="form-horizontal" id="formInfo">
								<div style="width: 100%; float: left;">

									<div style="width: 50%; float: left;">

										<div class="control-group">
											<label class="control-label">商品名称：</label>
											<div class="controls">
												<input class="dialogInput" id="productName" name="productName"
													value="${product.productName}">
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">商品分类：</label>
											<div class="controls">
												<select style="width: 140px;" id="categoryId1"
													onchange="categoryIdChange(this)" name="categoryId1">
													<c:forEach var="category" items="${category1List}">
														<option value="${category.productCategoryId}"
															<c:if test="${category.productCategoryId==parentCategoryId||category.productCategoryId==product.productCategoryId}" 
																>selected="selected"</c:if>>${category.name}</option>
													</c:forEach>
												</select>&nbsp;&nbsp;--&nbsp;&nbsp;<select style="width: 145px;"
													id="categoryId" name="categoryId">
													<c:forEach var="category" items="${categoryList}">
														<option value="${category.productCategoryId}"
															<c:if test="${category.productCategoryId==parentCategoryId||category.productCategoryId==product.productCategoryId}" 
																>selected="selected"</c:if>>${category.name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">商品价格：</label>
											<div class="controls">
												<input class="dialogInput" id="price" name="price"
													value="${product.price}">
											</div>
										</div>
									</div>



									<div style="width: 50%; float: right;">
										<div class="control-group">
											<label class="control-label" style="width: 80px;"><a id="addImgButton"
												class="btn btn-mini btn-success">添加图片</a></label>
											<div class="controls" style="margin-left: 95px;" id="ImgList">
												<c:forEach items="${productImg}" var="img">
													<div class="dialogDivImg"
														productImgId="${img.productImgId}"
														filePath="${img.filePath}" deleteFlag="1">
														<img alt="" src="${ctx}${img.filePath}" class="dialogImg">
														<div class="dialogAmargin">
															<a style="cursor: pointer;" onclick="deleteThis(this)"><i class="icon-remove"></i>删除</a> 
															<a style="margin-left:10px;cursor: pointer;" onclick="queryThis(this)"><i class="icon-search"></i>预览</a>
														</div>
													</div>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">商品简介：</label>
									<div class="controls">
										<textarea class="dialogInput" id="productContent"
											name="productContent" style="width: 800px; height: 200px;">${product.content}</textarea>
									</div>
								</div>

								<div class="form-actions" style="padding-left: 200px;">
									<span class="btn btn-warning" onclick="saveProduct()">保&nbsp;&nbsp;存</span>
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
</body>
</html>
<script type="text/javascript">
var productId='${product.productId}';
	$(function() {
		pageInit();		
		new window.AjaxUpload($('#addImgButton'),
			{
				action : '${ctx}/company!uploadProductImage.action',
				name : 'uploadFile',
				data:{size:0},
				responseType : 'json',
				onSubmit : function(file, ext) {
					if (ext != 'png' && ext != 'PNG' && ext != 'jpg'
							&& ext != 'JPG') {
						alert('请选择png,jpg文件类型！');
						return false;
					}
				},
				onComplete : function(file, response) {
					if (response.status == 200) {
						$('#ImgList').append('<div class="dialogDivImg" productImgId="" filePath="'
								+response.rows+'"><img alt="" src="${ctx}'
								+response.rows+'" class="dialogImg"><div class="dialogAmargin">'
								+'<a style="cursor: pointer;" onclick="deleteThis(this)"><i class="icon-remove"></i>删除</a>'
								+'<a style="margin-left:10px;cursor: pointer;" onclick="queryThis(this)"><i class="icon-search"></i>预览</a></div></div>');
					} else {
						alert(response.msg);
					}
				}
			});
		
	});
	function pageInit() {
		var str = "Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,SelectAll,Removeformat";
		str += ",Align,List,Outdent,Indent,Link,Unlink,Anchor,Img,Flash,Media,Hr,Emot,Table,Source,Preview";
		$('#productContent').xheditor({
			tools : str,
			upLinkUrl : "${ctx}/common!uploadHtmlFile.action",
			upLinkExt : "word,pdf,zip,rar,txt",
			upImgUrl : "${ctx}/common!uploadHtmlFile.action",
			upImgExt : "jpg,jpeg,gif,png,JPG,JPEG,GIF,PNG",
			upFlashUrl : "${ctx}/common!uploadHtmlFile.action",
			upFlashExt : "swf",
			upMediaUrl : "${ctx}/common!uploadHtmlFile.action",
			upMediaExt : "MP4,mp4,MP3,mp3,avi,AVI"
		});

	}
	
	function saveProduct(){
		var productData={};	
		productData["productId"]='${product.productId}';
		if($.trim($('#productName').val())==''){
			alert('商品名称不能为空！');return;
		}
		if($.trim($('#categoryId').val())==null||$.trim($('#categoryId').val())==''){
			alert('请选择商品分类！');return;
		}
		if($.trim($('#price').val())==''){
			alert('商品价格不能为空！');return;
		}else if(isNaN($.trim($('#price').val()))){
			alert('商品价格是数字类型！');return;
		}
		if($.trim($('#productContent').val())==''){
			alert('商品介绍不能为空！');return;
		}
		productData["productName"]=$.trim($('#productName').val());
		productData["categoryId"]=$.trim($('#categoryId').val());
		productData["price"]=$.trim($('#price').val());
		productData["content"]=$.trim($('#productContent').val());
		
		var addImg=[];
		$('#ImgList').find('.dialogDivImg').each(function(){
			if($(this).attr('productImgId')==''){
				addImg.push($(this).attr('filePath'));
			}			
		});
		productData["addFile"]=addImg.join(',');
		productData["delFile"]=delImg.join(',');
		$.ajax({
			type : 'post',
			url : '${ctx}/product!updateProductInfo.action',
			dataType : 'json',
			data : productData,
			success : function(msg) {
				if (msg.status == 200) {
					alert('保存成功！');
					window.history.go(-1);					
				} else {
					alert(msg.msg);
				}
			}
		});
		
	}

	function categoryIdChange(obj) {
		$
				.ajax({
					type : 'post',
					url : '${ctx}/product!findChildrenCategory.action',
					dataType : 'json',
					data : {
						categoryId : $(obj).val()
					},
					success : function(msg) {
						if (msg.status == 200) {
							var str = '';
							for ( var i = 0; i < msg.rows.length; i++) {
								str += '<option value="'+msg.rows[i]["productCategoryId"]+'">'
										+ msg.rows[i]["name"] + '</option>';
							}
							$('#categoryId').prev().find('span').html('');
							$('#categoryId').html(str);
						} else {
							alert(msg.msg);
						}
					}
				});

	}
	var delImg=[];	
	function deleteThis(obj){
		var $obj=$(obj).parents('.dialogDivImg');
		var productImgId=$obj.attr('productImgId');
		if(productImgId==''){
			$obj.remove();
		}else{
			delImg.push(productImgId);
			$obj.remove();
		}		
	}
	function queryThis(obj){
		var imgsrc = $(obj).parents('.dialogDivImg').find('img.dialogImg').attr('src');
		if ($('#lightbox').length > 0) {
			$('#imgbox')
					.html(
							'<img src="' + imgsrc + '" /><p><i class="icon-remove icon-white"></i></p>');
			$('#lightbox').slideDown(500);
		} else {
			var lightbox = '<div id="lightbox" style="display:none;">'
					+ '<div id="imgbox"><img src="' + imgsrc +'" style="width:auto;height:550px;margin-top:30px;" />'
					+ '<p><i class="icon-remove icon-white"></i></p>'
					+ '</div></div>';
			$('body').append(lightbox);
			$('#lightbox').slideDown(500);
		}
	}
</script>


