var groupNr = 0;
var url;

$.getJSON( "/milight/config", function(config){
	url = "http://" + config.host + ":" + config.port + "/"
});

$( document ).ready(function() {
	var MilightRGB = function(color) {
		$.post(url + "rgb" + "?group=" + groupNr + "&r=" + color.red + "&g=" + color.green + "&b=" + color.blue);
	};
	
	var MilightBrightness = function(brightness) {
		$.post(url + "brightness" + "?group=" + groupNr + "&level=" + brightness);
	};

	var MilightSimple = function(arg){
		$.post(url + arg + "?group=" + groupNr);
	}

	var MilightSpeedUp = function() {
		$.post(url + "disco" + "?group=" + groupNr + "&speed=up");
	};

	var MilightSpeedDown = function() {
		$.post(url + "disco" + "?group=" + groupNr + "&speed=down");
	};

	var MilightColor = function(color) {
		$.post(url + "color" + "?group=" + groupNr + "&color=" + color);
	};

	var RGBPreviewColorChange = function(color) {
    	$('#RGB').css('background', 'rgb('+color.red+','+color.green+','+color.blue+')');
    };

    $("#brightness").on('input change', function(event){
    	var brightness = $(event.target).val();
    	$("#brightnessVal").text(brightness);
    	MilightBrightness(brightness);
    });	

    $("#redInput").on('input change', function(event){
    	var red = $(event.target).val();
    	$("#RC").text(red);
    	SetRGB();
    });	

    $("#greenInput").on('input change', function(event){
    	var green = $(event.target).val();
    	$("#GC").text(green);
    	SetRGB();
    });	

    $("#blueInput").on('input change', function(event){
    	var blue = $(event.target).val();
    	$("#BC").text(blue);
    	SetRGB();
    });	

    var GetRGB = function(){
    	var red = $("#redInput").val();
    	var green = $("#greenInput").val();
    	var blue = $("#blueInput").val();

    	return {'red':red, 'green':green, 'blue':blue};
    }

    var SetRGB = function(){
    	var color = GetRGB();
    	MilightRGB(color);
    	RGBPreviewColorChange(color);
    };
	
	// var red = $('#R').slider().on('slide', RGB).data('slider');
	
	// var green = $('#G').slider().on('slide', RGB).data('slider');
	
	// var blue = $('#B').slider().on('slide', RGB).data('slider');
	
	// var brightness = $('#brightness').on('slide', MilightBrightness).data('slider');

	$('input[name=group]').change(function() {
		groupNr = $(this).attr("value");
	});

	$('.color').click(function() {
		color_raw = $(this).text().toLowerCase();
		color = color_raw.replace(" ", "_");
		MilightColor(color);
	});

	$('#on').click(function() {
		MilightSimple("on");
	});

	$('#off').click(function() {
		MilightSimple("off");
	});

	$('#night').click(function() {
		MilightSimple("night");
	});

	$('#white').click(function() {
		MilightSimple("white");
	});

	$('#disco').click(function() {
		MilightSimple("disco");
	});

	$('#speedUp').click(function() {
		MilightSpeedUp();
	});

	$('#speedDown').click(function() {
		MilightSpeedDown();
	});
});
