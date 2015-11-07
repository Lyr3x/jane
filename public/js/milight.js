$( document ).ready(function() {
	var groupNr

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
    	$('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
    };
	
	var red = $('#R').slider().on('slide', MilightRGB).data('slider');
	
	var green = $('#G').slider().on('slide', MilightRGB).data('slider');
	
	var blue = $('#B').slider().on('slide', MilightRGB).data('slider');
	
	var brightness = $('#brightness').slider().on('slide', MilightBrightness).data('slider');
	
	$('label[name=group]').click(function() {
		groupNr = $(this).attr("value");
		alert("groupNr" + groupNr);
	});
});
