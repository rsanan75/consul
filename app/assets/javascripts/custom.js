// Overrides and adds customized javascripts in this file
// Read more on documentation:
// * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md#javascript
// * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md#javascript
//
//

jQuery(document).ready(function () {
  jQuery(".subnavigation a").each(function () {
    if (jQuery(this).attr("href") == window.location.pathname) {
      jQuery(this).addClass("is-active");
    }
  });
  jQuery("a.title.disabled-title").each(function() {
    
    jQuery(this).removeAttr('href');
  });
  jQuery("a.title.disabled-title").on('click',function(e){
    e.preventDefault();
  });
  jQuery(".subnavigation a, .subfooter a").each(function () {
    if (jQuery(this).attr("href") == window.location.pathname) {
      jQuery(this).addClass("is-active");
    }
  });
}); 