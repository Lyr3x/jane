function add_entry() {
  $(".entries").append(
    "<div class='panel panel-default'>" +
      "<div class='panel-body'>" +
        "<button type='button' class='btn btn-xs btn-danger pull-right' onclick='remove_entry(this)'>" +
          "<span class='glyphicon glyphicon-remove'></span>" +
        "</button>" +
        "<div name='entry' class='form-group cron-entry'>" +
          "<div class='form-group'>" +
            "<label for='device' class='col-lg-2'>Device</label>" +
            "<input type='text' form='timetable' class='col-lg-8' name='entries[][device]'>" +
          "</div>" +
          "<div class='form-group'>" +
            "<label for='action' class='col-lg-2'>Action</label>" +
            "<input type='text' form='timetable' class='col-lg-8' name='entries[][action]'>" +
          "</div>" +
          "<div class='form-group cron-field'>" +
            "<label for='cron' class='col-lg-2'>Cron</label>" +
            "<input type='text' form='timetable' class='col-lg-8' name='entries[][cron]'>" +
          "</div>" +
          "<div class='checkbox'>" +
            "<label>" +
              "<input type='checkbox' name='entries[][home]'> Homecheck" +
            "</label>" +
          "</div>" +
        "</div>" +
      "</div>" +
    "</div>"
    );
}

function remove_entry(element){
  $(element).parent().remove();
}
