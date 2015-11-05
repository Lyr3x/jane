function add_command() {
  $(".commands").append(
  "<div class='panel panel-default'>" +
    "<div class='panel-heading'>" +
      "<div class='panel-title'>Command" + 
        "<button type='button' class='btn btn-xs btn-danger pull-right' onclick='remove_command(this)'><span class='glyphicon glyphicon-remove'></span></button>" +
      "</div>" +
    "</div>" +
    "<div class='panel-body'>" +
      "<div class='form-group'>" +
        "<label for='addon' class='col-sm-2 control-label'>Addon</label>" +
        "<div class='col-sm-10'>" +
          "<input type='text' class='form-control' name='commands[][addon]'>" +
        "</div>" +
      "</div>" +
      "<div class='form-group'>" +
        "<label for='sleep' class='col-sm-2 control-label'>Sleep</label>" +
        "<div class='col-sm-10'>" +
          "<input type='number' class='form-control' name='commands[][sleep]'>" +
        "</div>" +
      "</div>" +
      "<div class='parameter'>" +
        "<p><strong>Parameter</strong></p>" +
        "<div class='well well-sm col-sm-12 parameter-well'>" +
          "<button type='button' class='btn btn-xs btn-danger pull-right' onclick='remove_parameter(this)'><span class='glyphicon glyphicon-remove'></span></button>" +
          "<div class='form-group'>" +
            "<label for='para' class='col-sm-2 control-label'>Key</label>" +
            "<div class='col-sm-9'>" +
              "<input type='text' class='form-control' name='commands[][params][][key]'>" +
            "</div>" +
          "</div>" +
          "<div class='form-group'>" +
            "<label for='para' class='col-sm-2 control-label'>Value</label>" +
            "<div class='col-sm-9'>" +
              "<input type='text' class='form-control' name='commands[][params][][value]'>" +
            "</div>" +
          "</div>" +
        "</div>" +
      "</div>" +
        "<button type='button' class='btn btn-xs btn-success pull-right' onclick='add_parameter(this)'> Add Parameter <span class='glyphicon glyphicon-plus'></span></button>" +
        "</div>" +
    "</div>"
  );
}

function add_parameter(element){
  $(element).parent().find(".parameter").append(
    "<div class='well well-sm col-sm-12 parameter-well'>" +
      "<button type='button' class='btn btn-xs btn-danger pull-right' onclick='remove_parameter(this)'><span class='glyphicon glyphicon-remove'></span></button>" +
      "<div class='form-group'>" +
        "<label for='para' class='col-sm-2 control-label'>Key</label>" +
        "<div class='col-sm-9'>" +
          "<input type='text' class='form-control' name='commands[][params][][key]'>" +
        "</div>" +
      "</div>" +
      "<div class='form-group'>" +
        "<label for='para' class='col-sm-2 control-label'>Value</label>" +
        "<div class='col-sm-9'>" +
          "<input type='text' class='form-control' name='commands[][params][][value]'>" +
        "</div>" +
      "</div>" +
    "</div>"
  );
}

function remove_parameter(element){
  $(element).parent().remove();
}

function remove_command(element){
  $(element).parent().parent().parent().remove();
}
