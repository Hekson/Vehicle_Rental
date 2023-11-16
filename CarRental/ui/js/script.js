var SpawnCoords
var Heading

window.addEventListener('message', (event) => {
    let e = event.data;

    if (e.action === "open") {
        $('.d-none').css('display', 'block');
        $('.d-none').fadeIn(500);
    }
    SpawnCoords = e.SpawnCoords
    Heading = e.HeadingPoint
});

window.addEventListener("DOMContentLoaded", () => {
    var neon = document.getElementById('neon')
    neon.addEventListener('click', function() {
        $('.d-none').css('display', 'none');
        $('.d-none').fadeOut(500);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
        $.post(`https://${GetParentResourceName()}/createveh`,JSON.stringify({vehname: 'neon', SpawnCoords: SpawnCoords, HeadingPoint: Heading}));
    }, false);

    var t20 = document.getElementById('t20')
    t20.addEventListener('click', function() {
        $('.d-none').css('display', 'none');
        $('.d-none').fadeOut(500);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
        $.post(`https://${GetParentResourceName()}/createveh`,JSON.stringify({vehname: 't20', SpawnCoords: SpawnCoords, HeadingPoint: Heading}));
    }, false);

    var sabregt = document.getElementById('sabregt')
    sabregt.addEventListener('click', function() {
        $('.d-none').css('display', 'none');
        $('.d-none').fadeOut(500);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
        $.post(`https://${GetParentResourceName()}/createveh`,JSON.stringify({vehname: 'sabregt', SpawnCoords: SpawnCoords, HeadingPoint: Heading}));
    }, false);

    var infernus = document.getElementById('infernus')
    infernus.addEventListener('click', function() {
        $('.d-none').css('display', 'none');
        $('.d-none').fadeOut(500);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
        $.post(`https://${GetParentResourceName()}/createveh`,JSON.stringify({vehname: 'infernus', SpawnCoords: SpawnCoords, HeadingPoint: Heading}));
    }, false);
});

$(document).on("keydown", function(e){
    if (e.which == 27) {
        $('.d-none').css('display', 'none');
        $('.d-none').fadeOut(500);
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify());
    }
})