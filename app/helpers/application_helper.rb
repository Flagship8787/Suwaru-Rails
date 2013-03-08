module ApplicationHelper
  def modal_overlay(&block)
    return raw('<div id="modal_overlay_wrap">
    	<style type="text/css">
    	  #modal_overlay{
    			background-color:#fff;
    			display:none;
    			
    			width:780px;
    			
    			text-align:left;
    			border:2px solid #333;
    			
    			overflow:auto;
    			overflow-y:hidden;
    			
    			-moz-border-radius:6px;
    			-webkit-border-radius:6px;
    			-moz-box-shadow: 0 0 50px #ccc;
    			-webkit-box-shadow: 0 0 50px #ccc;
    		}
    	</style>
    	<script type="text/javascript">
    		$(function(){
    			$("#modal_overlay").overlay({
    				// some mask tweaks suitable for modal dialogs
    				mask: {
    					color: "#ebecff",
    					loadSpeed: 200,
    					opacity: 0.9
    				},
    				closeOnClick: false,
    				load:true,
    				top:"2%"
    			}).bind("onClose", function(){
    			  $("#modal_overlay_wrap").remove();
    			});
    		});
    	</script>
    	<div id="modal_overlay">' + capture(&block) + '</div>
    </div>')
  end
  
  def flag_link_for( flagged = nil )
    return raw(
      '<a href="#" class="flag_link" id="flag_' + flagged.type.to_s + '_' + flagged.id.to_s + '_link">
        <input type="hidden" class="f_type" value="' + flagged.type.to_s + '" />
        <input type="hidden" class="f_id" value="' + flagged.id.to_s + '" />
        Flag ' + flagged.type.to_s +
      '</a>'
    )
  end
  def nav_link_for( link_text, link_dest )
    link_open = nil
    
    puts "Request path = " + request.path
    puts "Link dest = " + link_dest
    
    if request.path == link_dest 
      link_open = '<li class="current">'
    else
      link_open = '<li>'
    end
    
    return raw(link_open + link_to(link_text, link_dest) + '</li>' )
  end
end
