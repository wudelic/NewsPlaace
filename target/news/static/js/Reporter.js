var ok1 = false;
var ok2 = false;
var ok3 = false;
var ok4 = false;
var ok5 = false;
var ok6 = false;
$(function(){

    $("#idNumber").blur(function(){
        $.ajax({
            url:"../../reporter/checkIdNumber",
            type:"POST",
            datatype:"json",
            data:{idNumber:$("#idNumber").val()},
            success:function (data) {
                if (data == 1){
                    $("#idNumber").css("border-color", "red");
                    $("#idNumberInfo").html("该证件号已被使用");
                }
            }
        })
    });
    $("#idNumber").blur(function(){
        var reg = /^[1-9]{1}[0-9]{14}$|^[1-9]{1}[0-9]{16}([0-9]|[xX])$/;
        if(reg.test($("#idNumber").val())){
            $("#idNumber").css("border-color", "green");
            $("#idNumberInfo").html("");
            ok6 = true;
            return true;
        }else{
            $("#idNumberInfo").html("不可用");
            $("#idNumber").css("border-color", "red");
            return false;
        }
    });

    $("#name").blur(function(){
        var e_RealName = $("#name").val();
        for (var i = 0; i < e_RealName.length; i++) {
            var j = e_RealName.substring(i, i + 1);
            if (j > 0) {
                $("#name").css("border-color", "red");
                $("#nameInfo").html("姓名中不能包含數字!");
                return false;
            }
        }
        if (e_RealName.trim().length <= 0) {
            $("#nameInfo").html("姓名不能為空!");
            $("#name").css("border-color", "red");
            return false;
        }
        $("#nameInfo").html("");
        $("#name").css("border-color", "green");
        ok1 = true;
        return true;
        });
    $("#phoneNum").blur(function(){
        var e_Phone = $("#phoneNum").val();
        var reg = /^1[345789]\d{9}$/;

        if (reg.test(e_Phone)==false) {
            $("#phoneNumInfo").html("手機號碼格式不正確，只能以13,14,15,17,18,19為開頭的11位數字");
            $("#phoneNum").css("border-color", "red");
            return false;
        }

        if (e_Phone.trim().length <= 0) {
            $("#phoneNumInfo").html("員工電話不能為空!");
            $("#phoneNum").css("border-color", "red");
            return false;
        }
        $("#phoneNumInfo").html("");
        $("#phoneNum").css("border-color", "green");
        ok2 = true;
        return true;
    });
    $("#email").blur(function () {
        var email = $("#email").val();
        var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
        if (re.test(email)){
            ok3 = true;
            $("#email").css("border-color", "green");
            return true;
        }
        else{
            $("#email").css("border-color", "red");
            return false
        }

        if(email.trim().length<=0){
            $("#emailInfo").html("電子郵箱不能為空");
            $("#email").css("border-color", "red");
            return false;
        }
        if(email.indexOf("@")==-1){
            $("#emailInfo").html("電子郵箱中必須包含符合@");
            $("#email").css("border-color", "red");
            return false;
        }
        if(email.indexOf(".")==-1){
            $("#emailInfo").html("電子郵箱中必須包含符合.");
            $("#email").css("border-color", "red");
            return false;
        }
        $("#emailInfo").html("");
        $("#email").css("border-color", "green");
        ok3 = true;
        return true;
    });
    $("#password").blur(function(){
        var pass = $("#password").val();
        if(pass.trim().length<6){
            $("#passwordInfo").html("密碼必須大於等於6位");
            $("#password").css("border-color", "red");
            return false;
        }
        $("#password").css("border-color", "green");
        ok4 = true;
        return true;
    });
    $("#rpassword").blur(function(){
        var pass = $("#password"); //第一次輸入的密碼
        var rp = $("#rpassword");  //確認密碼
        if(pass.val()!=rp.val()){
            $("#rpasswordInfo").html("兩次輸入的密碼不一致");
            $("#rpassword").css("border-color", "red");
            return false;
        }
        $("#rpasswordInfo").html("");
        $("#rpassword").css("border-color", "green");
        ok5 = true;
        return true;
    });

});
function check(){
    if (ok1 && ok2 && ok3 && ok4 && ok5 && ok6 && checkGender())
        return true;
    else{
        alert("请检查资料");
        return false
    }
}
function checkadd(){
    if (ok1 && ok2 && ok3 && ok4 && ok6 && checkGender())
        return true;
    else{
        alert("请填写好资料");
        return false
    }
}
function checkGender(){
    var sexs = document.getElementsByName("gender");
    var flag = 0;
    for (var i=0; i<sexs.length; i++){
        var sex = sexs[i];
        if (sex.checked)
            flag++;
    }
    if (flag == 0){
        alert("性别必须选择！");
        return false;
    }
    return true;
}


