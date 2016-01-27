function pageInit(obj) {
	var str = "Fontface,FontSize,Bold,Italic,Underline,Strikethrough,";
	str += "FontColor,BackColor,SelectAll,Removeformat,";
	str += "Align,List,Outdent,Indent,Link,Unlink,Anchor,Img,";
	str += "Flash,Media,Hr,Emot,Table,Source,Preview";
	$(obj).xheditor({
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