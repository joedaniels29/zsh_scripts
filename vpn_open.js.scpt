
JsOsaDAS1.001.00bplist00�Vscript_�function jd_main(){
delay(1)
var se = Application('System Events')
App = Application('Junos Pulse');
App.activate();
jps = se.processes.byName('Junos Pulse');
var menuitem= jps.menuBars[0].menuBarItems.byName("File").menus[0].menuItems[0].menus[0].menuItems[0];
if (menuitem.title() !="Connect"){
	jps.windows[0].close()
	return -1
}

menuitem.click()

//var safari = Application("Safari")
//safari.activate()
delay(5)
sp = se.processes.byName('Safari');
se.keyCode(36)
}

jd_main()                              �jscr  ��ޭ
