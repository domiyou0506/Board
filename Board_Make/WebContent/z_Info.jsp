<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ include file="./include/z_sessioncheck.jsp" %>
<%!public static boolean compareHobby(String[] arr, String item) {
		for (String i : arr) {
			if (i.equals(item)) {
				return true;
			}
		}
		return false;
	}%>
<%
	// String idx = (String)session.getAttribute("idx"); // idx를 사용하여 검색하면 속도가 유리(인덱싱)
	String userid = (String) session.getAttribute("userid");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String mem_name = "";
	String mem_hp = "";
	String mem_email = "";
	String[] hobbyArr = null;
	String mem_ssn1 = "";
	String mem_ssn2 = "";
	String mem_zipcode = "";
	String mem_address1 = "";
	String mem_address2 = "";
	String mem_address3 = "";
	String mem_gender = "";
	try {
		conn = Dbconn.getConnection();
		if (conn != null) {
			// *(별표) 절대 사용하지 말것!
			String sql = "select * from tb_member where mem_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mem_hp = rs.getString("mem_hp");
				mem_name = rs.getString("mem_name");
				mem_email = rs.getString("mem_email");
				hobbyArr = rs.getString("mem_hobby").split(" ");
				mem_ssn1 = rs.getString("mem_ssn1");
				mem_ssn2 = rs.getString("mem_ssn2");
				mem_zipcode = rs.getString("mem_zipcode");
				mem_address1 = rs.getString("mem_address1");
				mem_address2 = rs.getString("mem_address2");
				mem_address3 = rs.getString("mem_address3");
				mem_gender = rs.getString("mem_gender");
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보수정</title>
    <script defer src="./js/info.js">    
    </script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
</head>
<body>
    <h2>정보수정</h2>
    <form action="z_Info_ok" name="regform" id="regform" method="post" onsubmit="return sendit()">
        <!--method="post" 넘어갈때 보이지 않게 함  -->
        <p>아이디 :  <%=userid%> </p>
         
        <p>비밀번호: <input type="password" name="userpw" id="userpw" maxlength="20"></p>
        <p>비밀번호 확인: <input type="password" name="userpw_re" id="userpw_re" maxlength="20"></p>

        <p>이름: <input type="text"name="name" id="name" value="<%=mem_name%>"></p>
        <p>휴대폰 번호: <input type ="text" name="hp" id="hp" value="<%=mem_hp%>"></p>
        <p>이메일 <input type="text" name="email" id="email" value="<%=mem_email%>"></p>
        
        <p>성별 : 
        <label> 남자<input type="radio" name="gender" value="남자" <% if(mem_gender.equals("남자")) out.print("checked"); %>></label>
        <label>여자<input type="radio" name="gender" value="여자" <% if(mem_gender.equals("여자")) out.print("checked"); %>></label>
        </p>

		<p>주민등록번호 : <input type="text"  name="ssn1" value="<%=mem_ssn1%>"> - <input type ="text" name ="ssn2" value="<%=mem_ssn2%>"></p>

        <p>취미:
        <label>게임<input type="checkbox" name="hobby" value="게임"  
        <% if(compareHobby(hobbyArr, "게임")){
        	out.print("checked");
        	};%>></label>
        <label>등산<input type="checkbox" name="hobby" value="등산"
        <% if(compareHobby(hobbyArr, "등산")){
        	out.print("checked");
        	};%>></label>
        <label>영화감상<input type="checkbox" name="hobby" value="영화감상"
        <% if(compareHobby(hobbyArr, "영화감상")){
        	out.print("checked");
        	};%>></label>
        
        <label>운동<input type="checkbox" name="hobby" value="운동"
        <% if(compareHobby(hobbyArr, "운동")){
        	out.print("checked");
        	};%>></label>
        
        </p> 

        <p>우편번호 : <input type="text" id="sample6_postcode" name="zipcode" maxlength="5" value="<%=mem_zipcode%>"><button type="button" onclick="sample6_execDaumPostcode()">검색</button></p>    
        <p>주소 : <input type="text" name="address1" id="sample6_address" value="<%=mem_address1%>"> </p>
        <p>상세주소 : <input type="text" name="address2" id="sample6_detailAddress" value="<%=mem_address2%>"> </p>
        <p>참고항목 : <input type="text" name="address3" id="sample6_extraAddress" value="<%=mem_address3%>"> </p>

        <p><button>수정완료</button> <button type="reset">다시작성</button> <button type="button" onclick="location.href=z_Login.jsp'">돌아가기</button></p>
        <!-- 버튼의 기본은 서브밋 -->
    </form>
</body>
</html>




