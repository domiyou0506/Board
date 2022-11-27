function sendit(){

    const userid = document.getElementById('userid');
    const isIdCheck = document.getElementById('isIdCheck');
    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby= document.getElementsByName('hobby');
    

    // 정규표현식
    const expIdText = /^[A-Za-z]{4,20}$/;
    const expPwText =  /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}/;
    const expNameText = /[가-힣]+$/;
    const extHpText = /^\d{3}-\d{3,4}-\d{4}$/ ;
    const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;



    if(userid.value == ''){
        // 아무것도 입력되지 않는 아이디 칸
        alert('아이디를 입력하세요');
        userid.focus();
        return false;
        // 안넘어가게함
    }

    if(!expIdText.test(userid.value)){
        alert('아이디는 4자이상 20자 이하의 대소문자로 시작하는 조합입니다.');
        userid.focus();
        return false;
    }

    if(isIdCheck.value =="n"){
    		alert('아이디 중복체크버튼을 눌러주세요.');
            return false;

    }
    
    if(userpw.value == ''){
        // 아무것도 입력되지 않는 비밀번호 칸
        alert('비밀번호를 입력하세요');
        userpw.focus();
        return false;
        // 안넘어가게함
    }

    if(!expPwText.test(userpw.value)){
        alert('비밀번호 형식을 확인하세요 \n 소문자, 대문자, 숫자, 특수문자 1개씩을 꼭 포함해야합니다.');
        userpw.focus();
        return false;
    }

    if(userpw.value != userpw_re.value){
        alert('비밀번호와 확인 형식이 다릅니다.')

    }

    if(!expNameText.test(name.value)){
        alert('이름은 한글로 입력하세요');
        name.focus();
        return false;
    }

    if(!extHpText.test(hp.value)){
        alert('휴대폰번호 형식을 확인하세요 \n 하이픈(-)을 포함해야 합니다.');
        hp.focus();
        return false;
    }

    if(!expEmailText.test(email.value)){
        alert('이메일 형식을 확인하세요');
        return false;
    }

    let count = 0;
    for(let i in hobby){
        if(hobby[i].checked){
            count++;
        }
    }
    if(count == 0){
        alert('취미는 적어도 한개이상 선택하세요');
        return false;
    }
    return true;
    // 넘어가게함
}

window.onLoad = function(){
//	const xhr = new XMLHttpRequset();
//	const userid = document.getElementById('userid').value();
//	
//	xhr.open('get', 'idcheck.jsp?userid=' + userid, true);
	
}

function clickBtn(){
	const xhr = new XMLHttpRequest();
    const isidCheck = document.getElementById('isIdCheck');
    
    
	const userid = document.getElementById('userid').value;
	xhr.open('get', 'idcheck.jsp?userid=' + userid, true);
	xhr.send();

	xhr.onreadystatechange = function(){
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
			const result = xhr.responseText;
			if(result.trim() == "ok"){
				document.getElementById("checkmsg").innerHTML="<b style='color: deepskyblue'> 사용할 수 있는 아이디</br>"
					isIdCheck.value = "y";
			}else{
				document.getElementById("checkmsg").innerHTML="<b style='color: red'> 사용할 수 없는 아이디</br>"
			}
		}
	}
}
function idModify(){
	const isIdCheck = document.getElementById("isIdCheck");
	isIdCheck.value = "n";
	document.getElementById('checkmsg').innerHTML="";
}

















