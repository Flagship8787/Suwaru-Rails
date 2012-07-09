var isBusy = false;
function indicate_activity( dom_element ){
	if(dom_element.hasClass("indicating_activity")){
		dom_element.activity(false);
		dom_element.children().css("opacity", "1.0");
		
		dom_element.removeClass("indicating_activity");
	}else{
		dom_element.children().css("opacity", "0.2");
		dom_element.activity();
		
		dom_element.addClass("indicating_activity");
	}
}

var overlayBusy = false;
function indicate_overlay_activity( start ){
	if(overlayBusy == start){
		return;
	}	
	
	if(start == true){
		$("#modal_overlay_content").children().css("opacity", "0.2");
		$("#modal_overlay_content").activity();
		
		overlayBusy = true;
	}else{
		$("#modal_overlay_content").activity(false);
		$("#modal_overlay_content").children().css("opacity", "1.0");
		
		overlayBusy = false;
	}
}

$().ready(function(){
	$("a.flag_link").click(function(){
		var requestJSON = {
			"fid": $(this).find(".f_id").first().attr("value"),
			"ftype": $(this).find(".f_type").first().attr("value"),
			"overlay": 1
		};
	
		$.ajax({data:requestJSON, type:"POST", url:"/flags/new",
			beforeSend:function(xhr, settings){
				indicate_activity($("#main"));
			},complete:function(xhr, status){
			},success:function(data, status, xhr){	
				indicate_activity($("#main"));
				$("body").prepend(data);
			},error:function(xhr, settings, error){	
				indicate_activity($("#main"));
				alert("Failed to request flag form.");
			}
		});
	
		return false;
	});
});