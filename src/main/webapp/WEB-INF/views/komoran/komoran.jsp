<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
</style>

<meta charset="UTF-8">
<title>komoran</title>
</head>
<body>

<form id="uploadForm">
	<input type="file" name="file" />
	<button type="button" id="uploadBtn">Upload</button>
</form>

</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){
	 
	    $('#uploadBtn').on('click', function(){
	        uploadFile();
	    });
	 
	});
	 
function uploadFile(){
    
    var form = $('#uploadForm')[0];
    var formData = new FormData(form);
 
    $.ajax({
        url : '/komoran/sendfile',
        type : 'POST',
        data : formData,
        contentType : false,
        processData : false        
    }).done(function(data){
        alert(data);
    });
}
</script>

</html>