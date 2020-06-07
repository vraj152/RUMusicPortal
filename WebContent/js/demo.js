function getQueryStringValue (key) {
	return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
}

function updateUrlParameter (uri, key, value) {
	var
		i = uri.indexOf('#'),
		hash = i === -1 ? '' : uri.substr(i)
		;

	uri = i === -1 ? uri : uri.substr(0, i);

	var
		re = new RegExp("([?&])" + key + "=.*?(&|$)", "i"),
		separator = uri.indexOf('?') !== -1 ? "&" : "?"
		;

	if (!value) {
		// remove key-value pair if value is empty
		uri = uri.replace(new RegExp("([?&]?)" + key + "=[^&]*", "i"), '');

		if (uri.slice(-1) === '?') {
			uri = uri.slice(0, -1);
		}
		// replace first occurrence of & by ? if no ? is present

		if (uri.indexOf('?') === -1) {
			uri = uri.replace(/&/, '?');
		}

	} else if (uri.match(re)) {
		uri = uri.replace(re, '$1' + key + "=" + value + '$2');
	} else {
		uri = uri + separator + key + "=" + value;
	}
	return uri + hash;
}

var
	stretching = getQueryStringValue('stretching') || 'auto',
	stretchingSelector = document.querySelector('select[name=stretching]'),
	sourcesSelector = document.querySelectorAll('select[name=sources]'),
	sourcesTotal = sourcesSelector.length
;

for (var i = 0; i < sourcesTotal; i++) {
	sourcesSelector[i].addEventListener('change', function () {

		var
			media = this.closest('.players').querySelector('.mejs__container').id,
			player = mejs.players[media]
		;

		player.setSrc(this.value.replace('&amp;', '&'));
		player.load();
		if (!mejs.Features.isiOS && !mejs.Features.isAndroid) {
			player.play();
		}

	});

	if (mejs.Features.isiOS) {
		sourcesSelector[i].querySelector('option[value^="rtmp"]').disabled = true;
		if (sourcesSelector[i].querySelector('option[value$="webm"]')) {
			sourcesSelector[i].querySelector('option[value$="webm"]').disabled = true;
		}
		if (sourcesSelector[i].querySelector('option[value$=".mpd"]')) {
			sourcesSelector[i].querySelector('option[value$=".mpd"]').disabled = true;
		}
		if (sourcesSelector[i].querySelector('option[value$=".ogg"]')) {
			sourcesSelector[i].querySelector('option[value$=".ogg"]').disabled = true;
		}
		if (sourcesSelector[i].querySelector('option[value$=".flv"]')) {
			sourcesSelector[i].querySelector('option[value*=".flv"]').disabled = true;
		}
	}
}

document.addEventListener('DOMContentLoaded', function () {

	var mediaElements = document.querySelectorAll('video, audio'), i, total = mediaElements.length;

	for (i = 0; i < total; i++) {
		new MediaElementPlayer(mediaElements[i], {
			stretching: stretching,
			pluginPath: '../build/',
			success: function (media) {
			}
		});
	}
});