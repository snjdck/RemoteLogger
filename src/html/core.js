function include(src, callback)
{
	var element = document.createElement("script");
	element.type = "text/javascript";
	element.charset = "utf-8";
	element.src = src;
	element.onload = function(){
		element.onload = null;
		element.parentNode.removeChild(element);
		callback();
	};
	var head = document.getElementsByTagName("head")[0];
	head.appendChild(element);
}