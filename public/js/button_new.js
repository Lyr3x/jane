function add_command() {
    $(".commands").append(
        "<div class='well well-sm col-sm-offset-2 col-sm-7'>" +
         "<div class='form-group'> "+
           "<label for='addon' class='col-sm-3 control-label'>Addon</label>" +
           "<div class='col-sm-9'>" +
             "<input type='text' class='form-control' name='commands[][addon]'>" +
           "</div>" +
         "</div>" +
         "<div class='form-group'>" +
           "<label for='sleep' class='col-sm-3 control-label'>Sleep</label>" +
           "<div class='col-sm-9'>" +
             "<input type='number' class='form-control' name='commands[][sleep]'>" +
           "</div>" +
         "</div>" +
         "<div class='form-group'>" +
           "<label for='para' class='col-sm-3 control-label'>Parameter</label>" +
           "<div class='col-sm-4 parameter-field left'> "+
             "<input type='text' class='form-control' name='commands[][params][][key]'>" +
           "</div>" +
           "<div class='col-sm-4 parameter-field right'> "+
             "<input type='text' class='form-control' name='commands[][params][][value]'>" +
           "</div>" +
           "<button type='button' class='btn btn-sx btn-success parameter-btn' onclick='add_parameter(this)'><span class='glyphicon glyphicon-plus'></span></button>" +
         "</div>" +
        "</div>"
        );
}

function add_parameter(element){
    $(element).parent().append(
           "<div name='parameter'>" +
           "<label for='para' class='col-sm-3 control-label'></label>" +
           "<div class='col-sm-4 parameter-field left'> "+
             "<input type='text' class='form-control' name='commands[][params][][key]'>" +
           "</div>" +
           "<div class='col-sm-4 parameter-field right'> "+
             "<input type='text' class='form-control' name='commands[][params][][value]'>" +
           "</div>" +
           "</div>"
        );
}

$("action").change(function(){
  var device ={device: $("device").val()}
  console.log(device);
  $.get("actions", device, function(res){
    console.log(res);
    // if (!res) {
    //   return;
    // }
    // if (res) {};
  });
});
