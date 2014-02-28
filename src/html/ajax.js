function get(url, callback)
{
	var ldr = new XMLHttpRequest();
	ldr.onreadystatechange = onStateChange;
	ldr.open("GET", url, true);
	ldr.send(null);
	
	function onStateChange()
	{
		if(4 != ldr.readyState){
			return;
		}
		if(200 != ldr.status){
			callback(false, ldr.statusText);
			return;
		}
		callback(true, ldr.responseText);
	}
}