App.HTMLEditor =
  initialize: ->
    $(".html-area").each ->
      if $(this).hasClass("admin")
        CKEDITOR.replace(this.name, language: $("html").attr("lang"), toolbar: "admin")
      else
        CKEDITOR.replace(this.name, language: $("html").attr("lang"))
