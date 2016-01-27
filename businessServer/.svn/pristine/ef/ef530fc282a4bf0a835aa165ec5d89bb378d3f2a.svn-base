(function($) {
	function getnewStrData(cops) {
		var data = [];
		$(cops).find('tr:not(:eq(0))').each(function(k, v) {
			if (k > 0) {
				var back = -1, days = [], time = [];
				$(this).find('.tdbb').each(function() {
					var i = Number($.trim($(this).html()));					
					if (back > 0 && i != back) {
						days.push(time);						
						time = [];
					}
					back = i + 1;
					time.push(i);
				});
				if (back > 0) {
					days.push(time);
				}
				data.push(days);
			}
		});
		return data;
	}

	function getTextData(cops) {
		var data = {};
		var week=['星期一','星期二','星期三','星期四','星期五','星期六','星期日'];
		$(cops).find('tr:not(:eq(0))').each(function(k, v) {
			if (k > 0) {
				var back = -1,font = 0, days = [], time = [];				
				$(this).find('.tdbb').each(function() {
					var i = Number($.trim($(this).html()));
					if(back<0){
						font=i;
					}					
					if (back > 0 &&back<i) {
						var fontTime = font > 9 ? font : '0' + font;
						var backTime = back > 9 ? back : '0' + back;						
						time.push(fontTime + ':00-' + backTime+ ':00');
						font=i;					
					}
					back = i+1;					
				});
				if(back>0){
					var fontTime = font > 9 ? font : '0' + font;
					var backTime = back > 9 ? back : '0' + back;						
					time.push(fontTime + ':00-' + backTime+ ':00');
				}
				var str='暂停营业';
				if(time.length>0){
					str=time.join(',');
				}				
				data[week[k-1]]=str;			
			}
		});
		var value='';
		var font='';
		var back='';
		var textdata={};
		$.each(data,function(k,v){
			if(value==''){
				value=v;
				font=k;
			}else if(value==v){
				back=k;
			}else{
				if(back==''){
					textdata[font]=value;
				}else{
					textdata[font+'-'+back]=value;
				}
				value=v;
				font=k;
				back='';
			}				
		});
		if(value!=''){
			if(back==''){
				textdata[font]=value;
			}else{
				textdata[font+'-'+back]=value;
			}
		}
			
		return textdata;
	}
	function getStrData(cops) {
		var data = '[';
		var num = 0;
		$(cops).find('tr:not(:eq(0))').each(function(k, v) {
			if (k > 0) {
				var str = '';
				$(this).find('.tdbb').each(function() {
					str = str + $(this).html() + ',';
				});
				if ($.trim(str) != '') {
					str = str.substring(0, str.length - 1);
				} else {
					num++;
				}
				data = data + '[' + str + '],';
			}
		});
		if (num == 7) {
			return '';
		}
		return data.substring(0, data.length - 1) + ']';
	}

	function tabtdClick(cops) {
		$(cops).find('.span-spans').bind("click", function() {			
			var data=getTextData(cops);	
			var str='';
			$.each(data,function(k,v){
				str+=k+':'+v+'\n';
			});
			alert(str);			
		});
		$(cops).find('input').bind("click", function() {
			if ($(this).val() == 0) {
				var oldClass = 'tdbb';
				var newClass = 'tdbc';
				if (this.checked) {
					oldClass = 'tdbc';
					newClass = 'tdbb';
					$(cops).find('.tdbt').each(function() {
						$(this).attr('type', 1);
					});
					$(cops).find('input[name="timeHour"]').each(function() {
						$(this).attr('checked', true);
					});
				} else {
					$(cops).find('.tdbt').each(function() {
						$(this).attr('type', 0);
					});
					$(cops).find('input[name="timeHour"]').each(function() {
						$(this).attr('checked', false);
					});
				}
				$(cops).find('.' + oldClass).each(function() {
					$(this).attr('class', newClass);
				});
			} else if ($(this).val() != '' && $(this).val() > 0) {
				if (this.checked) {
					$(this).parent().parent().find('.tdbc').each(function() {
						$(this).attr('class', 'tdbb');
					});
				} else {
					$(this).parent().parent().find('.tdbb').each(function() {
						$(this).attr('class', 'tdbc');
					});
				}
			}
		});
		$(cops).find('.tdbt,.tdbb,.tdbc').bind("click", function() {
			var className = $(this).attr('class');
			if (className == 'tdbb') {
				$(this).attr('class', 'tdbc');
			} else if (className == 'tdbc') {
				$(this).attr('class', 'tdbb');
			} else if (className == 'tdbt') {
				var cnumHour = $(this).attr('numHour');
				var index = Number($(this).index()) + 1;
				if ($(this).attr('type') == 1) {
					$(this).attr('type', 0);
					$(cops).find('.tdbb').each(function() {
						if ($(this).html() == cnumHour) {
							$(this).attr('class', 'tdbc');
						}
					});
				} else if ($(this).attr('type') == 0) {
					$(this).attr('type', 1);
					$(cops).find('.tdbc').each(function() {
						if ($(this).html() == cnumHour) {
							$(this).attr('class', 'tdbb');
						}
					});
				}
			}
		});
	}
	function inittab(obj, opt) {
		var textvalue = [ 0, 1, 2, 3, 4, 5, 6, 7 ];
		var text = [ '全&nbsp;&nbsp;&nbsp;选', '星期一', '星期二', '星期三', '星期四', '星期五',
				'星期六', '星期日' ];
				
		var value = opt.setData;
		var str = '<tr><td colspan="20"><span class="span-spans">点击此处查看</span></td>';
		str += '<td class="title2" colspan="4">' + opt.firstTime + '</td>';
		str += '<td></td><td class="title1" colspan="4" >' + opt.lastTime
				+ '&nbsp;&nbsp;</td></tr>';

		for ( var i = 0; i < 8; i++) {
			str += '<tr><th class="tdpt"><input type="checkbox" value="'
					+ textvalue[i] + '" name="timeHour"/></th>';
			str += '<td class="tdbx">' + text[i] + '</td>';
			for ( var j = 0; j < 27; j++) {
				if (j % 7 == 6) {
					str += '<th class="tdbw"></th>';
				} else {
					var m = j - Math.floor(j / 7);
					if (i == 0) {
						str += '<th class="tdbt" type="0" numHour="' + m
								+ '"></th>';
					} else {
						var childvalue = [];
						if (i < value.length + 1) {
							childvalue = value[i - 1];
						}
						var boo = false;						
						for ( var n = 0; n < childvalue.length; n++) {
							for ( var k = 0; k < childvalue[n].length; k++) {
								var nn = Number(childvalue[n][k]);
								if (m == nn) {
									boo = true;
								}
							}									
						}
						if (boo) {
							str += '<th class="tdbb">' + m + '</th>';
						} else {
							str += '<th class="tdbc">' + m + '</th>';
						}
					}
				}
			}
			str += '</tr>';
		}
		$(obj).html(str);
	}
	
	$.fn.hourTime = function(options) {
		if (typeof options == "string") {
			return $.fn.hourTime.methods[options](this);
		}	
		return this.each(function() {
			var opt = $.extend({}, $.fn.hourTime.defaults, options);
			inittab(this, opt);
			tabtdClick(this);
		});
	};

	$.fn.hourTime.methods = {
		GetData : function(obj) {
			var data = [];
			$(obj).find('tr:not(:eq(0))').each(function() {
				var childata = [];
				$(this).find('.tdbb').each(function() {
					childata.push($(this).html());
				});
				data.push(childata);
			});
			data.shift();
			return data;
		},
		strData : function(obj) {
			
			return getStrData(obj);
		},
		textData : function(obj) {
			
			return getTextData(obj);
		},
		newStrData : function(obj) {
			
			return getnewStrData(obj);
		}
	};
	
	$.fn.hourTime.defaults = {
			width : '690px',
			cellspacing : "2px",
			cellpadding : "0",
			firstTime : '被选择时间',
			lastTime : '无选择时间',
			setData : []
		};
	
})(jQuery);
