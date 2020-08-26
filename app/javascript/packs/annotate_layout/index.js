import tippy from "tippy.js";

require("leaflet/dist/leaflet")
require("leaflet/dist/leaflet.css")

var mymap;
var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(mymap);
}

function annotate_image(img_id, image_url) {

    mymap = L.map(img_id, {
        crs: L.CRS.Simple
    });

    var bounds = [[0,0], [1000,1000]];
    var image = L.imageOverlay(image_url, bounds).addTo(mymap);
    mymap.fitBounds(bounds);
    var marker = L.marker([500, 500]).addTo(mymap);
    marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup();
    var popup = L.popup()
        .setLatLng([600, 400])
        .setContent("I am a standalone popup.")
        .openOn(mymap);
    mymap.on('click', onMapClick);
}

document.addEventListener("turbolinks:load", () => {
    alert('1');
    var image_url = $("#track").attr('src');
    alert(image_url);
    annotate_image('track', image_url );
})

