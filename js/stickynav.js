require(['jquery'], function($) {
  $(document).ready(function() {
    var sticky_navigation_offset_top = $('.sticky').offset().top;
    var sticky_navigation = function(){
      var scroll_top = $(window).scrollTop();
      if (scroll_top > sticky_navigation_offset_top) {
        $('.sticky').css({ 'position': 'fixed', 'top':0, 'left':0 });
      } else {
        $('.sticky').css({ 'position': 'relative' });
      }
    };

    sticky_navigation();

    $(window).scroll(function() {
      sticky_navigation();
    });

    $('a[href="#"]').click(function(event){
      event.preventDefault();
    });
  });
});
