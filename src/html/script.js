var logList = [];

var loggerIdFilter = {};
var levelFilter = [true, true, true, true, true];
var sectionFilter = {};

function toggleOutputLevel(level)
{
	levelFilter[level] = !levelFilter[level];
	filterContent();
}

function toggleOutputSection(section)
{
	sectionFilter[section] = !sectionFilter[section];
	filterContent();
}

function toggleOutputLoggerId(loggerId)
{
	loggerIdFilter[loggerId] = !loggerIdFilter[loggerId];
	filterContent();
}

function appendLog(loggerId, level, section, message)
{
	var log = {
		"loggerId":loggerId,
		"level":level,
		"section":section,
		"message":message
	};
	logList.push(log);
	
	if(!(loggerId in loggerIdFilter)){
		loggerIdFilter[loggerId] = true;
		if(loggerId){
			appendLoggerId(loggerId);
		}
	}
	
	if(!(section in sectionFilter)){
		sectionFilter[section] = true;
		if(section){
			appendSection(section);
		}
	}
	
	if(canFilter(log)){
		return;
	}
	
	var panel = document.getElementById("panel");
	panel.innerHTML += message;
	panel.scrollTop = panel.scrollHeight;
}

function onBodyInit()
{
}

function onClear()
{
	var panel = document.getElementById("panel");
	logList.length = 0;
	panel.innerHTML = "";
}

function appendLoggerId(loggerId)
{
	appendToFieldset("selectLoggerId", loggerId, function(){
		toggleOutputLoggerId(loggerId);
	});
}

function appendSection(section)
{
	appendToFieldset("selectSection", section, function(){
		toggleOutputSection(section);
	});
}

function appendToFieldset(parentId, inputId, onchange)
{
	var input = document.createElement("input");
	input.setAttribute("id", inputId);
	input.setAttribute("type", "checkbox");
	input.setAttribute("checked", "checked");
	input.onchange = onchange;
	
	var label = document.createElement("label");
	label.setAttribute("for", inputId);
	label.innerHTML = inputId;
	
	var section = document.getElementById(parentId);
	section.appendChild(input);
	section.appendChild(label);
}

function filterContent()
{
	var panel = document.getElementById("panel");
	var innerHTML = "";
	for(var i=0; i<logList.length; i++){
		var log = logList[i];
		if(canFilter(log)){
			continue;
		}
		innerHTML += log.message;
	}
	panel.innerHTML = innerHTML;
}

function canFilter(log)
{
	return !(loggerIdFilter[log.loggerId] && levelFilter[log.level] && sectionFilter[log.section]);
}