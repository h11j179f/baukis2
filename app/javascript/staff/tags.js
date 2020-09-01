require("jquery-ui")
require("tag-it")

$(document).on("turbolinks:load", () => {
  if ($("#tag-it").length) {
    $("#tag-it").tagit()
  }
})