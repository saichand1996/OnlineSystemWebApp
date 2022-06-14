<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="../js/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/mode-sparc.js" type="text/javascript"></script>
<script src="../js/sparc_programs.js" type="text/javascript"></script>
<script src="../js/script.js" type="text/javascript"></script>
<script src="../js/lessonDataStructureJSON.js"></script>

<title>Online SPARC</title>
<style type="text/css" media="screen">
#editor {
	position: fixed;
	margin: 0;
	float: left;
	width: 55%;
	height: 100%;
	top: 50;
}

#column-resizer {
	position: fixed;
	left: 56%;
	cursor: col-resize;
	margin: 0;
	padding: 0;
	width: 0.8%;
	height: 100%;
	background-color: #DDD;
	border-radius: 3px;
}

#results {
	position: relative;
	margin: 0;
	float: right;
	width: 39%;
}

ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	padding-left: 2em;
}

ul li {
	padding-left: 2em;
}

li {
	display: inline;
}

#txt_query {
	margin-top: 8px;
}

#btn_new {
	color: white
}

#btn_new:hover {
	color: black;
}
.nav .open>a, .nav .open>a:focus, .nav .open>a:hover {
    background-color: #3798d0;
    border-color: #337ab7;
}

</style>
</head>
<body>

	<!-- EASYTREE -->
	<link rel="stylesheet" type="text/css" href="../styles/easyTree.css">
	<link href="../styles/simple-sidebar.css" rel="stylesheet">


	<div id="wrapper" class="toggled">
		<div id="sidebar-wrapper">
			<div class="easy-tree" id="directory">
				<ul>
					<li>Example 3
						<ul>
							<li>Example 3a</li>
							<li>Example 3b</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div id="wrap">
			<div id="navbar">
				<header>
					<nav class="navbar navbar-dark bg-primary">
						<div class="container-fluid">
							<div class="collapse navbar-collapse">
								<ul class="nav navbar-nav navbar-left">
									<li>
										<button type="button" class="btn btn-default navbar-btn"
											id="menu-toggle" value="getAccessibleDirectory">Directory</button>
									</li>
									<!-- New Menu -->
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-haspop="true"
										aria-expanded="true" id="btn_new"> New <span class="caret"></span>
									</a>
										<ul class="dropdown-menu">
											<li><a href="#" id="newFolder">New Folder</a></li>
											<li><a href="#" id="newFile">New File</a></li>
										</ul></li>
									<!-- Save Button -->
									<li>
										<button type="button" class="btn btn-default navbar-btn"
											id="btn_save">Save</button>
									</li>

									
								</ul>
								<ul class="nav navbar-nav navbar-right">
									<li><input type="text" class="form-control"
										placeholder="Enter query" name="txt_query" id="txt_query"
										size="50"></li>
									<li>
										<button type="submit" class="btn btn-default navbar-btn"
											id="btn_getQuery" value="getQuery" onclick="submitrequest()">
											Submit</button>
									</li>
									<!-- <li>
										<button type="submit" class="btn btn-default navbar-btn"
											id="btn_saveSparcProgram" value="saveSparcProgram"
											onclick="saveSparcProgram()">Save Sparc Program</button>
									</li> -->
									<li>
										<button type="submit" class="btn btn-default navbar-btn"
											id="btn_getAnswerSets" value="getAnswerSets"
											onclick="answerSets()">Get Answer Sets</button>
									</li>
									<li></li>
									<li>
										<button type="submit" class="btn btn-default navbar-btn"
											id="btn_getAnimation" value="getAnimation"
											onclick="execute()">Execute</button>
									</li>
									<li></li>
								</ul>
							</div>
						</div>
					</nav>
				</header>
			</div>
		</div>
		
		<div id="page-content-wrapper">
			<div id="div_editorpanel">
                <div id="span_currentfolder"> 
                    Current folder:
                    <span id="span_currentfolderid"></span> 
                </div>
                <div id="span_currentfile"> 
                    Current file:
                    <span id="span_currentfileid"></span> 
                </div>

                <div id="div_fontsize">
                    <span> Font size: </span>
                    <select id="select_fontsize">
                        <option value="8">8px</option>
                        <option value="12" selected="selected">12px</option>
                        <option value="18">18px</option>
                        <option value="24">24px</option>
                        <option value="36">36px</option>
                        <option value="72">72px</option>
                    </select>
                </div>
				<div id="editor"></div>
			</div>
			<div id="column-resizer"></div>
			<div id="results"></div>
		</div>
	</div>




	<script src="scripts/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>

	<script src="../js/navbar-response.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="../js/easyTree.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/easytree-response.js" type="text/javascript"
		charset="utf-8"></script>

	<script src="../js/resizer.js" type="text/javascript"></script>
	<script src="../js/init.js" type="text/javascript"></script>
	<script type="text/javascript" src="../js/jquery.xslt.js"></script>
	<script type="text/javascript">
let currentLearningOutcomeNumber = sessionStorage.getItem(sessionKeyCurrentLearningOutcomeNumber);
let currentLessonNumber = sessionStorage.getItem(sessionKeyCurrentLessonNumber);
window.onload = function(){
	document.getElementById("sparc-footer-next-btn").disabled = true;
	let response = getSparcProgram(currentLearningOutcomeNumber);
	console.log(response);
	editor.setValue(response);
	
	}
	let userid = sessionStorage.getItem("userId");
	
	const apiBaseurl = "https://onlinelpk12dotnetapi.azurewebsites.net/api/sparc/";
	//var input="getAnswerSets";
    var editor = ace.edit("editor");
    editor.session.setMode("ace/mode/sparc");
	
    var showResults=function(response){
		$('#results').html('<center> <button onclick="clearResults()">Clear the Results</button> </center>');
		$('#results').append(response);
	}
    
	
	var clearResults=function(){
		$('#results').empty();
	}
	
	function execute(){
		let program = editor.getValue(); 
		if(program == null || program == '' || program == undefined){
			program = '';
		}
		let request = {
				 "userid": userid,
				 "learningOutcome":currentLearningOutcomeNumber,
				 "lessonId":  currentLessonNumber,
	             "action": "getAnimation",
	             "editor":  program
	         };
		PostSparc(request,"execute");
		document.getElementById("sparc-footer-next-btn").disabled = false;
	}
	
	function saveSparcProgram(){
		let program = editor.getValue(); 
		if(program == null || program == '' || program == undefined){
			return "Please enter valid Sparc program to save";
		}
		let request = {
				 "userid" : userid,
				 "learningOutcome":currentLearningOutcomeNumber,
				 "lessonId":  currentLessonNumber,
	             "editor":  program
	         };
		PostSparc(request,"save");
	}
	
	
	function answerSets(){
		let program = editor.getValue(); 
		
		if(program == null || program == '' || program == undefined){
			program = '';
		}
		let request = {
				"userid": userid,
				 "learningOutcome":currentLearningOutcomeNumber,
				 "lessonId":  currentLessonNumber,
	             "action": "getAnswerSets",
	             "editor":  program
	         };
		PostSparc(request,"execute");
		document.getElementById("sparc-footer-next-btn").disabled = false;
	}
	
	function submitrequest(){
		let program = editor.getValue(); 
		let query = $('#txt_query').val();
		if(program == null || program == '' || program == undefined){
			program = '';
		}
		if(query == null || query == '' || query == undefined){
			query = '';
		}
		let request = {
				"userid": userid,
				 "learningOutcome":currentLearningOutcomeNumber,
				 "lessonId":  currentLessonNumber,
	             "action": "getQuery",
	             "query" : query,
	             "editor":  program
	         };
		PostSparc(request,"execute");
		document.getElementById("sparc-footer-next-btn").disabled = false;
	}
	
	function PostSparc(request,suburl) {
		let url=suburl;
        let success = false;
        let res="";
        console.log('request: ', request);
        $.ajax({
       	 contentType:'application/x-www-form-urlencoded',
            data: request,
            success: function (data) {
                res= data;
            },
            type: 'POST',
            url: apiBaseurl + url,
            success: function(data){
            	console.log('response content: ',data.content);
            	showResults(data.content);
            	
            },
            error: function(data){
            	console.log(data);
            }
        });
	}
</script>
	<script type="text/javascript">
function SubmitSparc() {
	
    let _isSparcPassed = true;
    let sessionKeyIsSparcPassed ="isSparcPassed";
    if(_isSparcPassed==false){
    //validate sparc program
    
    return;
    
    }
    sessionStorage.setItem(sessionKeyIsSparcPassed, _isSparcPassed);
    let currentLessonNumber = parseInt(sessionStorage.getItem(sessionKeyCurrentLessonNumber));
    let currentLearningOutcomeNumber = parseInt(sessionStorage.getItem(sessionKeyCurrentLearningOutcomeNumber));
    let currentLessonDetails = lessonsJson.lessons.filter(lesson => lesson.lessonId == currentLessonNumber)[0];
        
    let isAssessmentPassed = sessionStorage.getItem(sessionKeyIsAssessmentPassed) === 'true';
    _isSparcPassed = sessionStorage.getItem(sessionKeyIsSparcPassed) === 'true';
    let message = document.getElementById('next-step-link');
    if (isAssessmentPassed && _isSparcPassed) {
        //sessionStorage.removeItem(sessionKeyIsAssessmentPassed);
        //let pageIdToShow = sessionStorage.getItem(sessionKeyShowPageId);
        //message.innerHTML = "Congratulations on completing the programming task. Please click <a href='" + nextLessonUrl + "'> here </a> to go to next steps."

        // student passed root assessment, so allow student to go to next lesson
        if (isAssessmentPassed && currentLearningOutcomeNumber == 0) {
            let nextLessonUrl = "../jsp/lesson" + (currentLessonNumber + 1) + ".jsp";
		window.location.href = nextLessonUrl;
           // message.innerHTML = "You have passed the root assessment. please click <a href='" + nextLessonUrl + "'> here </a> to go to next lesson";
        }
        // passed all learning outcomes in the lesson
        else if (isAssessmentPassed && currentLearningOutcomeNumber == currentLessonDetails.rootLearningOutcome.subLearningOutcomes.length) {
            let nextLessonUrl = "../jsp/lesson" + (currentLessonNumber + 1) + ".jsp";
		window.location.href = nextLessonUrl;
            //message.innerHTML = "You have passed all the assessments. please click <a href='" + nextLessonUrl + "'> here </a> to go to next lesson";
        }
        else if (isAssessmentPassed && currentLearningOutcomeNumber > 0) {
            let nextLessonUrl = "../jsp/lesson" + (currentLessonNumber) + ".jsp";

            let nextLearningOutcomeDetails = currentLessonDetails.rootLearningOutcome.subLearningOutcomes.filter(x=> x.learningOutcomeId ==  currentLearningOutcomeNumber+1)[0];
            let showPageId = nextLearningOutcomeDetails.pages[0].pageId;
            sessionStorage.setItem(sessionKeyShowPageId,showPageId);
	    window.location.href = nextLessonUrl;
            //message.innerHTML = "You have passed assessment Please click <a href='" + nextLessonUrl + "'> here </a> to go to next learning outcome";
        }
    }
    }
</script>
	<%@ include file="sparc-footer.jsp"%>
</body>
</html>
