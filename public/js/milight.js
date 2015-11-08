var groupNr = 0;

$( document ).ready(function() {
	var MilightRGB = function() {
		$.post("http://192.168.2.101:8080/rgb" + "?group=" + groupNr + "&r=" + red.getValue() + "&g=" + green.getValue() + "&b=" + blue.getValue());
	};
	
	var MilightBrightness = function() {
		$.post("http://192.168.2.101:8080/brightness" + "?group=" + groupNr + "&level=" + brightness.getValue());
	};

	var MilightSimple = function(arg){
		$.post("http://192.168.2.101:8080/" + arg + "?group=" + groupNr);
	}

	var MilightSpeedUp = function() {
		$.post("http://192.168.2.101:8080/disco" + "?group=" + groupNr + "&speed=up");
	};

	var MilightSpeedDown = function() {
		$.post("http://192.168.2.101:8080/disco" + "?group=" + groupNr + "&speed=down");
	};

	var MilightColor = function(color) {
		$.post("http://192.168.2.101:8080/color" + "?group=" + groupNr + "&color=" + color);
	};

	var RGBChange = function() {
    	$('#RGB').css('background', 'rgb('+red.getValue()+','+green.getValue()+','+blue.getValue()+')')
    };

    $("#brightness").slider();
    $("#brightness").on("slide", function(slideEvt) {
			$("#brightnessVal").text(slideEvt.value);
    });

    var RGB = function(){
    	MilightRGB();
    	RGBChange();
    };
	
	var red = $('#R').slider().on('slide', RGB).data('slider');
	
	var green = $('#G').slider().on('slide', RGB).data('slider');
	
	var blue = $('#B').slider().on('slide', RGB).data('slider');
	
	var brightness = $('#brightness').slider().on('slide', MilightBrightness).data('slider');

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
