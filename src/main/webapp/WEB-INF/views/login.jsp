<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<div class="login">
	<section class="login-contents">
		<div class="login-box">
			<form action="">
				<h1 class="login-title">
					<a href="#">E-Accounting111</a>
				</h1>
				<div class="field">
					<div class="login-item control control--reset">
						<input id="id" class="input" type="text" placeholder="아이디" tabindex="1"/>
						<input name="returnUrl" class="input" type="hidden" value="${name}"/>
						<button class="clear-btn" type="button">지우기</button>
					</div>
					<div class="login-item control">
						<input id="password" class="input" type="password" placeholder="비밀번호" tabindex="2"/>
					</div>
					<div class="control">
						<button id="btnLogin" class="button" tabindex="3">로그인</button>
					</div>
				</div>
			</form>
		</div>
	</section>
</div>

<script type="text/javascript">
	$(document).on('click', '#btnLogin', function(){

		login();
	});

	function login() {
		var userId = $('#id').val();
		var password = $('#password').val();

		if (userId == '') {
			alert('사용자아이디를 입력하세요.');
		} else if (password == '') {
			alert('비밀번호를 입력하세요.');
		} else {
			var url='login';
			var params = {
				"id"		: userId
				,"password" : password
				,"returnUrl" : $("input[name=returnUrl]").val()
			};

			$.ajax({
				url: url,
				type: 'POST',
				data: params,
				beforeSend: function(){
					$("#btnLogin").attr('disabled', true);
					$("#loading").show();
				},
				complete:function(data){
					$("#btnLogin").attr('disabled', false);
					//어차피 페이지 이동하므로 hide()가 필요없음..
					//$("#loading").hide();
				}
			}).done(function (result) {
				loginCallback(result);
			}).fail(function(xhr, textStatus, errorThrown) {
				if(xhr.status =='403'){
					alert("해당 기능에 대한 권한이 없습니다.");
				}
			});
		}
	}

	function loginCallback(data) {
		if ('success' == data.status) {
			alert('로그인에 성공했습니다.');
			if (data.returnUrl.length > 0) {
				window.location.href = data.returnUrl;
			}
			else {
				window.location.href = "/";
			}
		} else if ('fail' == data.status) {
			alert('로그인에 실패했습니다. \n'+data.msg);
			$("#loading").hide();
		} else{
			//nothing
		}
	}

</script>