var pageinfo = {
	page : 1,
	t : 0,
	size : 10,
	tp : 0
};

function initpageInfo(total) {
	if (total % pageinfo["size"] == 0)
		pageinfo["tp"] = total / pageinfo["size"];
	else
		pageinfo["tp"] = Math.ceil(total / pageinfo["size"]);
	$("#pager").pager({
		pagenumber : pageinfo["page"],
		pagecount : pageinfo["tp"],
		datacount : total,
		buttonClickCallback : PageClick
	});
}

function setpageinfo(page, size) {
	if (size != undefined) {
		pageinfo["size"] = size;
		$('#pagesize').html(size);
	}
	if (page == undefined) {
	} else if (page == -1)
		pageinfo["page"]--;
	else if (page == -2)
		pageinfo["page"]++;
	else {
		if (page >= pageinfo["tp"] && pageinfo["tp"] > 0)
			pageinfo["page"] = pageinfo["tp"];
		else
			pageinfo["page"] = page;
	}
}

PageClick = function(pageclickednumber) {
	loadData(pageclickednumber);
};


function closeDialog(obj1,obj2){
	$('#'+obj1).css({
		display : 'none'
	});
	$('#'+obj2).css({
		display : 'none'
	});	
}

function openDialog(obj1,obj2){
	$('#'+obj1).css({
		display : 'block'
	});
	$('#'+obj2).css({
		display : 'block'
	});	
}

