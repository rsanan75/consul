(function() {
  "use strict";
  App.AdvancedSearch = {
    advanced_search_terms: function() {
      return $("#js-advanced-search").data("advanced-search-terms");
    },
    toggle_form: function(event) {
      event.preventDefault();
      $("#js-advanced-search").slideToggle();
    },
    toggle_date_options: function() {
      if ($("#js-advanced-search-date-min").val() === "custom") {
        $("#js-custom-date").show();
        $(".js-calendar").datepicker("option", "disabled", false);
      } else {
        $("#js-custom-date").hide();
        $(".js-calendar").datepicker("option", "disabled", true);
      }
    },
    init_calendar: function() {
      var locale;
      locale = $("#js-locale").data("current-locale");
      $(".js-calendar").datepicker({
        maxDate: "+0d",
        dateFormat: 'dd/mm/yy'
      });
      $(".js-calendar-full").datepicker({ dateFormat: 'dd/mm/yy'});
      $(".datepicker-ui").datepicker({
        dateFormat: 'dd/mm/yy', 
        changeMonth: true,
        changeYear: true,
        minDate: '-116Y',
        maxDate: '-18Y', 
        yearRange: "1930:-18" });
      $.datepicker.setDefaults($.datepicker.regional[locale]);
    },
    initialize: function() {
      App.AdvancedSearch.init_calendar();
      if (App.AdvancedSearch.advanced_search_terms()) {
        $("#js-advanced-search").show();
        App.AdvancedSearch.toggle_date_options();
      }
      $("#js-advanced-search-title").on({
        click: function(event) {
          App.AdvancedSearch.toggle_form(event);
        }
      });
      $("#js-advanced-search-date-min").on({
        change: function() {
          App.AdvancedSearch.toggle_date_options();
        }
      });
    }
  };
}).call(this);
