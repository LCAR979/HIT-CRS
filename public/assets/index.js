function clearActive(e){var r,t;for(t=e.length,r=0;t>r;r++)hasClass(e[r],"active")&&removeClass(e[r],"active")}function addClass(e,r){var t=e.className;(""!=t||void 0!=t)&&(t+=" "),e.className=t+r}function removeClass(e,r){var t=e.className,c=t.indexOf(r);-1!=c&&(0!=c&&(r=" "+r),e.className=t.replace(r,""))}function hasClass(e,r){var t,c=e.className.split(" "),n=c.length;for(t=0;n>t;t++)if(c[t]==r)return!0;return!1}function replaceClass(e,r,t){removeClass(e,r),addClass(e,t)}function changePages(e,r,t,c,n,l){var a;for(a=0;t>a;a++)a==c-1?r>c?(replaceClass(e[a],"move-on",n),replaceClass(e[r-1],l,"move-on")):c>r&&(replaceClass(e[a],"move-on",l),replaceClass(e[r-1],n,"move-on")):r-1>a?hasClass(e[a],l)&&replaceClass(e[a],l,n):a>r-1&&hasClass(e[a],n)&&replaceClass(e[a],n,l)}var currentArticlePage,currentSectionPage;window.onload=function(){var e=document.querySelectorAll(".theme-nav ul li"),r=document.querySelectorAll(".content-nav ul li");currentArticlePage=1,currentSectionPage=1,function(){var t,c,n=document.querySelector("body");for(c=e.length,t=0;c>t;t++)e[t].addEventListener("click",function(){var r=this.dataset.page,t=document.querySelectorAll(".a"+currentArticlePage+" nav ul li"),c=document.querySelectorAll("article");0!=t.length&&t[0].click(),currentSectionPage=1,clearActive(e),addClass(this,"active"),r!=currentArticlePage&&(changePages(c,r,c.length,currentArticlePage,"move-left","move-right"),currentArticlePage=r)},!1);for(c=r.length,t=0;c>t;t++)r[t].addEventListener("click",function(){var e=this.dataset.page,r=document.querySelectorAll(".a"+currentArticlePage+" nav ul li"),t=document.querySelectorAll(".a"+currentArticlePage+" section");clearActive(r),addClass(this,"active"),e!=currentSectionPage&&(changePages(t,e,t.length,currentSectionPage,"move-up","move-down"),currentSectionPage=e)},!1);n.addEventListener("mousewheel",function(e){var r=document.querySelectorAll(".a"+currentArticlePage+" nav ul li");if(e.wheelDelta>0){if(1==currentSectionPage)return;0!=r.length&&r[currentSectionPage-2].click()}else{if(currentSectionPage==r.length)return;0!=r.length&&r[currentSectionPage].click()}},!1),n.addEventListener("keydown",function(e){var r=document.querySelectorAll(".theme-nav ul li"),t=document.querySelectorAll(".a"+currentArticlePage+" nav ul li"),c=r.length;if(37==e.keyCode){if(1==currentArticlePage)return;r[currentArticlePage-2].click()}else if(38==e.keyCode){if(1==currentSectionPage)return;0!=t.length&&t[currentSectionPage-2].click()}else if(39==e.keyCode){if(currentArticlePage==c)return;r[currentArticlePage].click()}else if(40==e.keyCode){if(currentSectionPage==t.length)return;0!=t.length&&t[currentSectionPage].click()}},!1)}()};