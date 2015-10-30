function change(){
        var st=document.getElementsByName("work");
		//var staff=document.getElementByValue("staff");
		var dep=document.getElementById("dep");
		var stNum=document.getElementById("stNum");
		var staffNum=document.getElementById("staffNum");
        if(st[1].checked==true){
			dep.style.display="none";
			stNum.style.display="none";
			staffNum.style.display="block";
        }
		if(st[1].checked==false){
			dep.style.display="block";
			stNum.style.display="block";
			staffNum.style.display="none";
		}
    }