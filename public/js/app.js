$(function () {
    var fragments, closeAlert, action_button;

    // make the buttons behave like links
    $('.lien').click(function (e) {
        window.location = e.target.dataset.target;
    });

    // Make the alert disappear
    closeAlert = function () {
        if ($('.alert').length !== 0) {
            $('.alert').alert('close');
        }
    };
    _.delay(closeAlert, 3000);

    // Navigation code
    Navigation.init();

    //initiate datepicker on the fiche form
    if ($('#done_at').length !== 0) {
        $("#datepicker").datepicker({
            autoclose: true,
            language: 'fr-FR'
        });
    }

    action_button = function (fiche_id) {
        var actionlink = $("tr.ficheRow[data-fiche_id=" + fiche_id + "] a.action")[0];
        return $("<button>")
            .addClass("pull-left btn btn-success")
            .attr("id", "modal-action")
            .text(actionlink.title)
            .click(function (e) {
                if (actionlink.click !== undefined) {
                    actionlink.click();
                }
            });
    };

    // Allow linkage on the fiche table
    $("tr.ficheRow").delegate('.icon-eye-open', 'click', function (e) {
        e.preventDefault();
        var fiche_id = e.delegateTarget.dataset.fiche_id;
        if ($("#ficheDetails").data("modal") !== undefined) {
            $("#ficheDetails").data('modal').options.remote = "/fiche/" + fiche_id;
            $("#ficheDetails").modal('reload');

        } else {
            $("#ficheDetails").modal({
                remote: "/fiche/" + fiche_id
            });
        }

        $("#ficheDetails").find("#modal-action").each(function (i, v) {
            $(v).remove();
        });

        if ($(e.delegateTarget).find("a.action").length > 0) {
            $(".modal-footer").append(
                action_button(fiche_id)
            );
        }
        $('#imprimer').data("fiche_id", fiche_id);
    });

    // Allow auto opening of the modal
    if (!_.isNull(fragments = /#(\d+)\/?(.*)$/.exec(window.location.hash))) {
        $("tr.ficheRow[data-fiche_id=" + fragments[1] + "] .icon-eye-open").click();
    }

    // Event for opening the print window
    $("#ficheDetails").delegate('#imprimer', 'click', function (e) {
        window.open("/print/" + $(e.target).data("fiche_id"));
    });
});

(function ($arr) {
    $arr.init = function (errors) {
        if (errors !== {}) {
            $(':input, .input-prepend').each(function (i, e) {
                if (errors[e.id] !== undefined) {
                    $("<span class='help-inline'>" + errors[e.id][0] + "</span>").insertAfter($(e));
                    $(e).parent().addClass('error');
                }
            });
        }
    };

})(ErrorDisplay = {});

(function ($arr) {
    $arr.init = function () {
        $('.navbar li:has(a[href="' + window.location.pathname + '"])').addClass('active');
    };
})(Navigation = {});
