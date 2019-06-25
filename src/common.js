const MSGTYPE = {
	kOpenURL: '100',
	kOpenApp: '101'
};

var sendNativeResponse = function (msg) {
	if (window.webkit) {
		window.webkit.messageHandlers.native.postMessage(msg);
	}
};

var openURL = function (app_url, app_name) {
	if (typeof native != "undefined") {
		var parameter = {'URL': app_url};
		native.openURLJS(parameter);
	} else if (window.webkit) {
		sendNativeResponse({
			type: MSGTYPE.kOpenURL,
			tag: app_name,
			URL: app_url
		});
	}
};

var openApp = function (app_bundleId, app_url) {
	if (typeof native != "undefined") {
		var parameter = {'bundleId': app_bundleId, 'appURL': app_url};
		native.openAppJS(parameter);
	} else if (window.webkit) {
		sendNativeResponse({
			type: MSGTYPE.kOpenApp,
			bundleId: app_bundleId,
			URL: app_url
		});
	}
};

String.format = function() {
    if (arguments.length == 0)
        return null;
    var str = arguments[0];
    for ( var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
};

var wkSetLanguage = function (language) {
	switch (language) {
		case 'zh-Hans':
			wkRunLocalization(ATLocalization_zhCN);
			break;
		case 'zh-Hant':
			wkRunLocalization(ATLocalization_zhTW);
			break;
		case 'de':
			wkRunLocalization(ATLocalization_de);
			break;
		case 'es':
			wkRunLocalization(ATLocalization_es);
			break;
		case 'fr':
			wkRunLocalization(ATLocalization_fr);
			break;
		case 'it':
			wkRunLocalization(ATLocalization_it);
			break;
		case 'ko':
			wkRunLocalization(ATLocalization_ko);
			break;
		case 'nl':
			wkRunLocalization(ATLocalization_nl);
			break;
		case 'en':
			wkRunLocalization(ATLocalization_en);
			break;
		default:
			wkRunLocalization(ATLocalization_en);
	}
};

var setLanguage = function(language) {
    $('.wrapper').children().each(function(){
        $(this).addClass(language);
    });

    $.getScript("localization/"+language+".lproj/LocalizationString.js", function(data, textStatus, jqxhr) {
        runLocalization();
    });
};

var runLocalization = function() {
    $("#title-content").html(ATLocalization.Product_Title);
    $("#description-content-1").html(ATLocalization.Product_Description_1);
    $("#description-content-2").html(ATLocalization.Product_Description_2);
    $("#btn-cancel-title-content").html(ATLocalization.Button_Cancel);
    $("#btn-open-title-content").html(ATLocalization.Button_Open);
};

var wkRunLocalization = function(wkWordings) {
	$("#title-content").html(wkWordings.Product_Title);
	$("#description-content-1").html(wkWordings.Product_Description_1);
	$("#description-content-2").html(wkWordings.Product_Description_2);
	$("#btn-cancel-title-content").html(wkWordings.Button_Cancel);
	$("#btn-open-title-content").html(wkWordings.Button_Open);
};

var initEvent = function() {
    $(".btn-cancel").click(function() {
        window.location.href="http://closewindow";
    });

    $(".btn-open").click(function() {
        openApp('com.haowudev.openanyfiles', 'macappstore://itunes.apple.com/app/id1250827715?mt=12&at=1001ldFh&ct=Cleaner.BuyDrFile.V1001');
    });
};

$(document).ready(function(){
    //setLanguage("en");
    initEvent();
});