// Show/Hide the tool icons on the right of each bookmark
$("#bookmarks").delegate('li','mouseover mouseout', function(e){
    if (e.type == 'mouseover') {
	$(this).children(".tools").show();
    } else {
	$(this).children(".tools").hide();
    }
});
// Create a view per button and dynamicly update type and title
$(function() {
    $('.lien').click(function(e){
	window.location = e.target.dataset.target;
    });

      Navigation.init();

      if ($('#done_at').length != 0) {
	$("#done_at").datepicker({
	dateFormat: 'dd/mm/yy'
	});
      }
});

(function($arr)
 {
     /**
      * Setup class
      */
     $arr.init = function(errors)
     {
	 if (errors != {}) {
	     $(':input').each(function(i,e){
		 if (errors[e.id] != undefined) {
		     $("<span class='help-inline'>" + errors[e.id][0] + "</span>").insertBefore($(e));
		     $(e).parent().addClass('error');
		 }
	     });
	 }
     };

 })(ErrorDisplay = {});

var Navigation = {};

(function($arr)
 {
     /**
      * Setup class
      */
     $arr.init = function(errors)
     {
	 $('.navbar li:has(a[href="' + window.location.pathname + '"])').addClass('active');
     };

 })(Navigation = {});
