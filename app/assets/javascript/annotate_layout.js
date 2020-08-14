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
    var url = "/layouts/load_points?strategy=" + strategy;
    var request = $.get( url, function( notes ) {
        importPoints(img, notes);
    });
    request.done(function(){
        // alert('Recarregado!');
    });
    request.fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
    });

}


function savePoints(img) {
    var strategy = $("#track").data("strategy");
    var notes = img.imgNotes("export")
    var url = "/layouts/save_points?strategy=" + strategy;
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

function annotate_layout() {
    var track_image = $("#track");
    var edit = (track_image.data("edit") == true);
    var img = track_image.imgNotes({
        canEdit: edit,
        zoomable: false,
        dragable: false
    });

    // var notes = track_image.data("notes");
    // importPoints(img, notes);

    $(document).keypress(function(e) {
        // alert(e.which);
        //D
        if (e.which == '100') { removeLastPoint(img); }
        //V
        if (e.which == '118') { reload_points(img); }
        //S
        if (e.which == '115') { savePoints(img); }
    });

    reload_points(img)
}
