
// Check to see if the page is outside of the frameset
	if (top.location == self.location) {
		// If it isn't in the frameset, get the filename
		var file_name = document.location.href;
		var end = (file_name.indexOf("?") == -1) ? file_name.length : file_name.indexOf("?");
		// Then load the file in the frameset and append the filename at the end
		self.location.replace("index.html?"+file_name.substring(file_name.lastIndexOf("/")+1, end));
	}
	// If it is in the frameset, it's fine.
	else {
	}
