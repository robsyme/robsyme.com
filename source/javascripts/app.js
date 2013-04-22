$(document).ready(function(){
    $("#table-of-contents").appendTo("aside");

    $(".outline-3").waypoint(function(direction) {
        var a = $(this).attr('id');
        var t = a.replace("outline-container", "#sec");
        var s = 'a[href$="'.concat(t,'"]');
        var n = $(s).parent().toggleClass("outline-3-scroll-selected", direction === 'up');
    }, {
        offset: function() {
            return -$(this).height();
        }
    });

    $(".outline-3").waypoint(function(direction) {
        var a = $(this).attr('id');
        var t = a.replace("outline-container", "#sec");
        var s = 'a[href$="'.concat(t,'"]');
        var n = $(s).parent().toggleClass("outline-3-scroll-selected", direction === 'down');
    }, {
        offset: '100%'
    });


    
    $(".outline-2").waypoint(function(direction) {
        var a = $(this).attr('id');
        var t = a.replace("outline-container", "#sec");
        var s = 'a[href$="'.concat(t,'"]');
        var n = $(s).parent().toggleClass("outline-2-scroll-selected", direction === 'up');
    }, {
        offset: function() {
            return -$(this).height();
        }
    });

    $(".outline-2").waypoint(function(direction) {
        var a = $(this).attr('id');
        var t = a.replace("outline-container", "#sec");
        var s = 'a[href$="'.concat(t,'"]');
        var n = $(s).parent().toggleClass("outline-2-scroll-selected", direction === 'down');
    }, {
        offset: '100%'
    });
});
