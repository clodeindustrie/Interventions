$(function() {
    // make the buttons behave like links
    $('.lien').click(function(e){
    	window.location = e.target.dataset.target;
    });

    // Display a fiche infos
    _.templateSettings = {
      interpolate : /\{\{(.+?)\}\}/g
    };

    if ($('#ficheDetails').length !=0 ) {
	var template = _.template($("#ficheDetails").html());
    }

    // Make the aler disappear
    var closeAlert = function(){
    	if ($('.alert').length != 0) {
            $('.alert').alert('close');
    	}
    };
    _.delay(closeAlert, 3000);

    // Navigation code
    Navigation.init();

    //initiate datepicker on the fiche form
    if ($('#done_at').length != 0) {
	$("#done_at").datepicker({
	    dateFormat: 'dd/mm/yy'
	});
    }

    // Allow linkage on the fiche table
    $("tr.ficheRow").delegate('.icon-eye-open', 'click', function(e){
	$.getJSON('/fiche/' + e.delegateTarget.dataset.fiche_id, function(data){
	    template(data);
	});
    });
});

(function($arr)
 {
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

(function($arr)
 {
     $arr.init = function()
     {
	 $('.navbar li:has(a[href="' + window.location.pathname + '"])').addClass('active');
     };
 })(Navigation = {});
