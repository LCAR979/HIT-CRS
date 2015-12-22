function change(){
        var st=document.getElementsByName("identity");
		var dep=document.getElementById("dep");
		var stNum=document.getElementById("stNum");
		var staffNum=document.getElementById("staffNum");
		var invitation = document.getElementById("invitation");
        if(st[1].checked==true){
			dep.style.display="none";
			stNum.style.display="none";
			invitation.style.display="block";
			staffNum.style.display="block";
        }
		else{
			invitation.style.display="none";
			dep.style.display="block";
			stNum.style.display="block";
			staffNum.style.display="none";
		}
    }