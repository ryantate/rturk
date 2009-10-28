// Get the filename from the url (for forwards from pages loaded outside a frameset)
		var myPage = top.document.location.search.substr(1);

		// This is the function that loads the new page (if there is one) into the mainFrame.
		function loadContent() {
			i = document.getElementsByTagName('FRAME')[2];

			// If we find something after the "?", load that file in the mainFrame.
			if (myPage.length > 0) {
				// If the link is from the "Get Started" button, handle it.
				if (myPage.lastIndexOf(".html") == -1){
					var iSrc = i.getAttribute("src");
					myPage = iSrc;
				}
				else {
					i.src = myPage;
				}
			}
			else {
				// If we don't find anything, set the variable to the default first page.
				var iSrc = i.getAttribute("src");
				myPage = iSrc;
			}
		}

		// Get the filename of the loaded page, strip out the suffix, and pass it on.
		function extractFileName() {
			var path = window.frames['mainFrame'].document.location.pathname;
  			var lastSlash = path.lastIndexOf("/");
  			var fileName = path.substring(lastSlash+1,path.length);
			var myLink = fileName.slice(0,-5);
			//alert(myLink);
			highlight(myLink);
		} 
		
		// Highlight the TOC entry of the loaded page, and pass along variables.
		function highlight(name) {
			var jsFrame = window.frames['navFrame'];
			var syncId = "t-" + name;
			jsFrame.changeColor(syncId);
			syncUp(name,syncId);
			setTimeout(function(){scrollNow(syncId);},50)
			//scrollHold(syncId);
		}
		
		// Synchronize the TOC with the content displayed in the mainFrame.
		function syncUp(id,tId) {
			var jsFrame = window.frames['navFrame'];
			var linkId = jsFrame.document.getElementById(id);
			var tLinkId = jsFrame.document.getElementById(tId);
			var parent_node = tLinkId.parentNode.parentNode.parentNode.parentNode.parentNode;
			var sibling_node = tLinkId.parentNode.parentNode.childNodes[1];
			var par = parent_node.id;
			var syncPar = "t-" + id;
			var topParent = jsFrame.document.getElementsByTagName("TABLE")[1];
			if (sibling_node) {
				jsFrame.tocShowChildren(id);
				if (parent_node && parent_node != topParent) {
					syncUp(par,syncPar);
				}
				else if (!parent_node) {
				}
			}
			else if (!sibling_node) {
				if ( parent_node && parent_node != topParent) {
					syncUp(par,syncPar);
				}
				else if (!parent_node) {
				}
			}
		}
		
		function scrollHold(i) {
			//thisObj = this;
			//alert(i);
			setTimeout(scrollNow(i), 1000);
		}
		
		function scrollNow(i) {
			//alert(i);
			var jsFrame = window.frames['navFrame'];
			var scrollId = jsFrame.document.getElementById(i)
			scrollId.scrollIntoView(true);
		}
