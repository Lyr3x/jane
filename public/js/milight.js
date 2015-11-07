$( document ).ready(function() {
	var groupNr = 0;

	var MilightRGB = function() {
		$.post("http://192.168.2.101:8080/rgb" + "?group=" + groupNr + "&r=" + red.getValue() + "&g=" + green.getValue() + "&b=" + blue.getValue());
	};
	
	var MilightBrightness = function() {
		// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
		$.post("http://192.168.2.101:8080/brightness" + "?group=" + groupNr + "&level=" + brightness.getValue());
	};
	
	var MilightOff = function() {
		// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
		$.post("http://192.168.2.101:8080/off" + "?group=" + groupNr);
	};
	
	var MilightOn = function() {
		// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
		$.post("http://192.168.2.101:8080/on" + "?group=" + groupNr);
	};

	var RGBChange = function() {
    	$('#RGB').css('background', 'rgb('+red.getValue()+','+green.getValue()+','+blue.getValue()+')')
    };

    $("#brightness").slider();
    $("#brightness").on("slide", function(slideEvt) {
			$("#brightnessVal").text(slideEvt.value);
    });
	
	var red = $('#R').slider().on('slide', MilightRGB, RGBChange).data('slider');

	
	var green = $('#G').slider().on('slide', MilightRGB, RGBChange).data('slider');
	
	var blue = $('#B').slider().on('slide', MilightRGB, RGBChange).data('slider');
	
	var brightness = $('#brightness').slider().on('slide', MilightBrightness).data('slider');
	
	$('label[name=group]').click(function() {
		groupNr = $(this).attr("value");
		alert("groupNr" + groupNr);
	});
});
