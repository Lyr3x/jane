function add_entry() {
  $(".entries").append(
    "<div name='entry'>" +
      "<label for='device'>Device</label>" +
      "<input type='text' form='timetable' name='entries[][device]'>" +
      "<label for='action'>Action</label>" +
      "<input type='text' form='timetable' name='entries[][action]'>" +
      "<label for='cron'>Cron</label>" +
      "<input type='text' form='timetable' name='entries[][cron]'>" +
      "<button type='button' class='btn btn-xs btn-danger' onclick='remove_entry(this)'>" +
      "<span class='glyphicon glyphicon-remove'>" +
      "</span></button>" +
    "</div>"
    );
}

function remove_entry(element){
  $(element).parent().remove();
}
