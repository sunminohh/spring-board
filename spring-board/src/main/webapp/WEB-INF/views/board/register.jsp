<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

<style>

.uploadResult {
	
	width:100%;
	background-color: white;
}

.uploadResult ul {

	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {

	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	
	width: 100px;
}

.uploadResult ul li span {

	color:black;
}

</style>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Board Register</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/board/register" method="post">
                        		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
                        	
                        		<div class="form-group">
                        			<label>Title</label><input class="form-control" name='title'>
                        		</div>
                        		
                        		<div class="form-group">
                        			<label>Text area</label>
                        			<textarea class="form-control" rows="3" name='content'></textarea>
                        		</div>
                        		
                       			<div class="form-group">
                       				<label>Writer</label><input class="form-control" name='writer'
                       					value='<sec:authentication property="principal.username" />' readonly="readonly">
                       			</div>
                       			<button type="submit" class="btn btn-info">Submit</button>
                       			<button type="reset" class="btn btn-default">Reset</button>
                        	</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
            	<div class="col-lg-12">
	            	<div class="panel panel-default">
	            		
	            		<div class="panel-heading">File Attach</div>
	            		
	            		<div class="panel-body">
	            			<div class="form-group uploadDiv">
								<input type="file" name='uploadFile' multiple>	            			
	            			</div>
	            			
	            			<div class='uploadResult'>
	            				<ul>
	            				
	            				</ul>
	            			</div>
	            		</div>
	            	</div>
            		
            	</div>
            </div>
            


<script type="text/javascript">
$(document).ready(function(e){
	
	let formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		
		e.preventDefault();
		
		console.log("submit clicked");
		
		let str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			
			let jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";                       
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";                       
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";                       
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";                       
		});
		
		formObj.append(str).submit();
	});
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize) {
		
		if (fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if (regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;
	};
	
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
	
		let formData = new FormData();
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;
		
		for(let i=0; i<files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData, 
			type: 'POST',
			dataType: 'json',
			 success: function(result){
				 console.log(result);
				 showUploadResult(result); //업로드 결과 처리 함수
			 }
		}); //$.ajax
		
	});
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
		
		let uploadUL = $(".uploadResult ul");
		
		let str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			// image type
			if(obj.image){
				
				let fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_" 
						+ obj.uuid + "_" + obj.fileName);
				
				str += "<li data-path='" +obj.uploadPath+ "'";    
				str += " data-uuid='" +obj.uuid+"' data-filename='" + obj.fileName+ "' data-type='" +obj.image+ "'";
				str += " ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" +fileCallPath+ "\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName=" +fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
			
			}else {
				let fileCallPath = encodeURIComponent( obj.uploadPath+ "/" 
						+ obj.uuid + "_" + obj.fileName);
				
				let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li "
				str += "data-path='" +obj.uploadPath+ "' data-uuid='" +obj.uuid+"' data-filename='" + obj.fileName+ "' data-type='" +obj.image+ "' ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" +fileCallPath+ "\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str += "</li>";
			}
		
		});
		
		uploadUL.append(str);
	}
	
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		
		let targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr) {
				xhr.setRequetHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType: 'text',
			type: 'POST',
			 success: function(result){
				 alert(result);
				 targetLi.remove();
			 }
		}); //$.ajax
		
	});
	
})		
</script>
   
       <%@include file="../includes/footer.jsp" %>