---
---

require ['jquery'], ($) ->
  $(document).ready ->
    stickyNavigationOffsetTop = $('.sticky').offset().top
    stickyNavigation = ->
      scrollTop = $(window).scrollTop()
      if scrollTop > stickyNavigationOffsetTop
        $('.sticky').css
          'position': 'fixed',
          'top': 0,
          'left': 0
      else
        $('.sticky').css
          'position': 'relative'

    stickyNavigation()

    $(window).scroll stickyNavigation

    $('a[href="#"]').click (event) ->
      event.preventDefault()
