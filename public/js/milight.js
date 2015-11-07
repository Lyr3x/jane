var groupNr

var MilightRGB = function() {
	$.post("http://192.168.2.101:8080/rgb" + "?group=" + groupNR + "&r=" + red + "&g=" + green + "&b=" + blue);
};

var MilightBrightness = function() {
	// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
	$.post("http://192.168.2.101:8080/brightness" + "?group=" + groupNR + "&level=" + brightness);
};

var MilightOff = function() {
	// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
	$.post("http://192.168.2.101:8080/off" + "?group=" + groupNR);
};

var MilightOn = function() {
	// $.post("http://192.168.2.101:8080/brightness", { group: groupNR, level: brightness })
	$.post("http://192.168.2.101:8080/on" + "?group=" + groupNR);
};

var red = $('#r').slider()
				.on('slide', MilightRGB)
				.data('slider');

var green = $('#g').slider()
					.on('slide', MilightRGB)
					.data('slider');

var blue = $('#b').slider()
					.on('slide', MilightRGB)
					.data('slider');

var brightness = $('#brightness').slider()
								.on('slide', MilightBrightness)
								.data('slider');

$(document).ready(function() {
	$('.group').click(function() {
		groupNr = $(this).attr("value");
	});
});

