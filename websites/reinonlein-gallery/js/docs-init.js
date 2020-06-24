(function($){
  $(function(){

    M.AutoInit();

    // Dropdown
    $('.dropdown-trigger').dropdown({
      coverTrigger: false,
      constrainWidth: false
    });


    // Home
    $('.carousel').carousel({
      dist: 0,
      padding: 10
    });


    $('a.filter').click(function (e) {
      e.preventDefault();
    });



    // Contact Form Icon
    $("form .form-control").focus(function() {
      $(this).siblings("label").first().children("i").first().css({"color": "#aaa", "left": 0});
    });
    $("form .form-control").blur(function() {
      $(this).siblings("label").first().children("i").first().css({"color": "transparent", "left": "-20px"});
    });


    var onShow = function(el) {
      var carousel = el.find('.carousel');
      carousel.carousel({
        dist: 0,
        padding: 10
      });
    };
    $('.gallery-expand').galleryExpand({
      onShow: onShow,
      dynamicRouting: true,
    });

    $('.blog .gallery-expand').galleryExpand({
      onShow: onShow,
      dynamicRouting: true,
      fillScreen: true,
      inDuration: 500,
    });

    // Docs init
    $('.gallery-expand.fill-screen').galleryExpand({
      onShow: onShow,
      fillScreen: true
    });
    var toc = $('.table-of-contents');
    toc.pushpin({ top: toc.offset().top });
    $('.scrollspy').scrollSpy();

  }); // end of document ready
})(jQuery); // end of jQuery name space