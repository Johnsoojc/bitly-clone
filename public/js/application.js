$(document).ready(function(){
  $("#create_url").on("submit", function(event){
    event.preventDefault()
    form_inputs = $(this).serialize()
    $.ajax({
      url: "/test",
      method: "post",
      data: form_inputs,
      dataType: "json",
      success: function(data){
        $("tbody").append(
          "<tr><td><a href=" + data.long_url + ">" +
            data.long_url + "</a>" +
            "</td><td><a href=" + data.short_url + ">" + "localhost9393/"
            data.short_url + "</a>" +
            "</td><td>" +
            data.click_count +
            "</td><td></td></tr>"
        )
      }
    })
  })
})

//asynchronous javascript and xml
