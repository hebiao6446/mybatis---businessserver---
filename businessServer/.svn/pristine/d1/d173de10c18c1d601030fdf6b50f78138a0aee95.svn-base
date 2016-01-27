
$(document).ready(function(){
	
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	
	$('select').select2();
	
	// Form Validation
    $("#basic_validate").validate({
		rules:{
			name:{
				required:true
			},
			operateScope:{
				required:true
			},
			linkman:{
				required:true
			},
			linkmanTel:{
				required:true
			},
			registDate:{
				required:true 
			},
			companyType:{
				required:true
			},
			companyInfo:{
				required:true 
			},
			email:{
				required:true,
				email: true
			},
			companyURL:{
				required:true,
				url:true
			},
			address:{
				required:true,
			}
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
	});
	
	
    
});
