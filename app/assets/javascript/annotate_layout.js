function importPoints(img, points) {
    img.imgNotes("clear");
    if (Array.isArray(points)) {
        img.imgNotes("import", points);
    }
}

function removeLastPoint(img) {
    var points = img.imgNotes("export")
    if (Array.isArray(points)) {
        points.pop();
        importPoints(img, points)
    }
}

function reload_points(img) {
    var strategy = $("#track").data("strategy");
    var url = "/strategies/load_points?strategy=" + strategy;
    var notes = []
    var request = $.get( url, function( data ) {
        notes = data;
    });
    request.done(function(){
        importPoints(img, notes);
        // alert( "ok" );
    });
    request.fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
    });

}

function load_points(image_id){
    var track_image = $(image_id);
    var img = track_image.imgNotes();
    reload_points(img);
}


function savePoints(img) {
    var strategy = $("#track").data("strategy");
    var notes = img.imgNotes("export")
    var url = "/strategies/save_points?strategy=" + strategy;
    var request = $.ajax({
        method: "POST",
        url: url,
        data: { strategy: strategy, notes: notes }
    })
    request.done(function(){
            alert('Salvo!');
    });
    request.fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
    });
}

function annotate_layout(image_id) {
    var track_image = $(image_id);
    var edit = (track_image.data("edit") == true);
    var img = track_image.imgNotes({
        canEdit: edit,
        zoomable: false,
        dragable: false
    });

    $(document).keypress(function(e) {
        // alert(e.which);
        //D
        if (e.which == '100' && edit) { removeLastPoint(img); }
        //V
        if (e.which == '118') { reload_points(img); }
        //S
        if (e.which == '115' && edit) { savePoints(img); }
    });
    reload_points(img)
}

document.addEventListener("turbolinks:load", function() {
    if ($("#track").length) {
        annotate_layout("#track");
    }
});