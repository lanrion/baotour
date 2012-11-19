//beta 001版
$.fn.mytime = function() {

		var self = this;

//		alert($(self).length)
		$(self).each(function(){
			  var that = this;
				//alert($(this).attr("title"))
				var title = $(that).attr("title")

				var d = new Date(title);
				var month= d.getMonth()+1;
				var day=d.getDate();
				var h=d.getHours();
				var m=d.getMinutes();
				var s=d.getSeconds();	

			//	var dstr=d.getFullYear()+'-'+month+'-'+day+' '+h+':'+m+':'+s;
				//alert( title.getDate());
				var dstr=d.getFullYear()+'-'+month+'-'+day
				$(that).text(dstr)
		})
}


Number.prototype.formatMoney = function(c, d, t) {
		var n = this, 
				c = isNaN(c = Math.abs(c)) ? 0 : c, 
				d = d == undefined ? "." : d, 
				t = t == undefined ? "," : t, 
				s = n < 0 ? "-" : "", 
				i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
				j = (j = i.length) > 3 ? j % 3 : 0;
   			return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };
 
 $.fn.mymoney = function(){
	$(this).each(function(){
		var that = this;
		var money = parseInt($(that).attr("money"));
		$(that).text((money).formatMoney());
	})
	
}
