var parallax = document.querySelectorAll('.parallax')
for (var i = 0; i < parallax.length; i++){
	M.Parallax.init(parallax[i]);
}

var tabs = document.querySelectorAll('.tabs')
for (var i = 0; i < tabs.length; i++){
	M.Tabs.init(tabs[i]);
}

var sidenavs = document.querySelectorAll('.sidenav')
for (var i = 0; i < sidenavs.length; i++){
	M.Sidenav.init(sidenavs[i]);
}
