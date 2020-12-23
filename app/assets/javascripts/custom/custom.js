// Overrides and adds customized javascripts in this file
// Read more on documentation: 
// * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md#javascript
// * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md#javascript
//
//

jQuery(document).ready(function () {
  jQuery(".subnavigation a, .subfooter a").each(function () {
    if (jQuery(this).attr("href") == window.location.pathname) {
      jQuery(this).addClass("is-active");
    }
  });
  jQuery("a.title.disabled-title").each(function () {
    jQuery(this).removeAttr('href');
  });
  jQuery("a.title.disabled-title").on('click', function (e) {
    e.preventDefault();
  });
  jQuery(".subnavigation a, .subfooter a").each(function () {
    if (jQuery(this).attr("href") == window.location.pathname) {
      jQuery(this).addClass("is-active");
    }
  });
  jQuery('span[data-responsive-toggle="responsive-menu"]').on('click', function () {
    jQuery('#responsive-menu').toggle();
  });
  jQuery('.menu-icon').on('click', function () {
    jQuery('#responsive-menu').toggle();
  });
  if (jQuery('.proposals-listing').length) {
    jQuery('ul.tags li').each(function () {
      jQuery('ul.categories').append(jQuery(this).clone());
    });
  }
  if (jQuery('.report-doc-description').length && jQuery('.report-docs .help-text').length) {
    jQuery('.report-docs .documents-list .help-text').append('<br>' +jQuery('.report-doc-description').text());
  }
  if (jQuery('.report-image-description').length && jQuery('.report-images .help-text').length) {
    jQuery('.report-images .images .help-text').append('<br>'+jQuery('.report-image-description').text());
  }
  
});