<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.keji09.com/jstl/11erp" prefix="erp"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle res = ResourceBundle.getBundle("11erp");
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>结算列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="${cp }/manager/js/date/WdatePicker.js"></script>
    <style type="text/css">
    	.qrcodeIcon {
		    background-image: url(images/ermIcon.png?v=201507271756);
		    background-position: 11px 10px;
		    background-repeat: no-repeat;
		    display: inline-block;
		    height: 25px;
		    width: 33px;
		}
		.qrcodeBox {
		    background-color: #fff;
		    border: 1px solid #cfcfcf;
		    border-radius: 4px;
		    height: 150px;
		    left: 80px;
		    margin-top: -58px;
		    padding: 5px;
		    position: absolute;
		    width: 150px;
		    z-index: 1000;
		}
		.td2_name{
			position: absolute;
			left: 35%;
			text-align: center;
		}
    </style>
    <script type="text/javascript">
    			function showImg(index){
			document.getElementById("wxImg"+index).style.display='block';
		}
		function hideImg(index){
			document.getElementById("wxImg"+index).style.display='none';
		}
		function showURL(id){
			alert("<%=res.getString("project.host")%>/kj/"+id);
		}
    </script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    <h5>结算列表</h5>                   
                    </div>
                    <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" role="grid">
							<form action="${pageContext.request.contextPath }/settlement/list" method="get">
								<div class="row">
									<div class="col-sm-6">
										<div class="dataTables_length" id="DataTables_Table_0_filter">
											<label>
											<input   value="${type}" name="type" type="hidden">
												查找：
					                        	<input type="text"  value="${code}" name="code" placeholder="根据单号查询">
					                        	<input type="text" name="startTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="初始时间" value="${startTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="height: 26px; width: 170px;margin-left: 43px"/>
					                        	<input type="text" name="endTime" readonly="readonly" class="form-control" onClick="WdatePicker()" class="Wdate" placeholder="截止时间" value="${endTime }" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="height: 26px; width: 170px;margin-left: 43px"/>
					                        	<input type="submit" class="btn btn-sm btn-primary" value="搜索"> 
					                        	<br>
					                        	<font size="5px">
					                        	总交易额：<fmt:formatNumber value="${sum}" maxFractionDigits="2"></fmt:formatNumber>元&nbsp;&nbsp;
					                        	总手续费：<fmt:formatNumber value="${fee}" maxFractionDigits="2"></fmt:formatNumber>元&nbsp;&nbsp;
					                        	总利润:<fmt:formatNumber value="${lr}" maxFractionDigits="2"></fmt:formatNumber>元
					                        	</font>
												<fm
											</label>
										</div>
									</div>
									<div class="col-sm-6">
										<div id="DataTables_Table_0_length" class="dataTables_filter"  >
											<label>每页
												<select class="form-control input-sm" aria-controls="DataTables_Table_0" name="pageSize" onchange="javascript:this.form.submit();">
													<c:if test="${pageSize!=null}">
														<option value="${pageSize }">${pageSize }</option>
													</c:if>
													<option value="10">10</option>
													<option value="25">25</option>
													<option value="50">50</option>
													<option value="100">100</option>
												</select> 条记录
											</label>
										</div>
									</div>
                 				  </form>
								</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed">
	                            <thead class="pn-lthead">
	                                <tr>
	                                    <th>结算单号</th>
	                                    <th>结算总金额</th>
	                                    <th>手续费</th>
	                                    <th>实际结算金额</th>
	                                    <th>添加时间</th>
                                    	<th>操作</th>                                 
	                                </tr>
	                            </thead>
	                            <tbody  id="idsVal">
	                            <c:forEach items="${list}" var="items">
		                            		<td>
		                            			${items.code}
		                            		</td>
		                            		<td>
		                            		<fmt:formatNumber value="${items.sum}" maxFractionDigits="2"></fmt:formatNumber>元
		                            		</td>
		                            		<td>
		                            		<fmt:formatNumber value="${items.ptMoney+items.terMoney}" maxFractionDigits="2"></fmt:formatNumber>
		                            		</td>
		                            		<td>
		                            			<fmt:formatNumber value="${items.money}" maxFractionDigits="2"></fmt:formatNumber>元
		                            		</td>
		                            		<td>
		                            			<fmt:formatDate value="${items.addTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both" />
		                            		</td>
		                            		<td>
												<a class="pn-opt" onclick="detial(${items.code})">订单详情</a>
		                            		</td>
		                            		
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
                        <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="settlement/list" method="get">
		                                    <input value="${type}" name="type" type="hidden">
		                                    <input value="${code}" name="code" type="hidden">
		                                    <input value="${startTime}" name="startTime" type="hidden">
		                                    <input value="${endTime}" name="endTime" type="hidden">
		                                        <%@include file="paging.jsp" %>
		                                    </form>
		                                </td>
		                            </tr>
		                        </tbody>
		                    </table>
	                 	</div>	
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js?v=2.1.4"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript">
    </script>
    <script type="text/javascript">
    		function detial(code){
		 	layer.open({
			type: 2,
			title: '查看结算订单详情',
			shadeClose: true,
			moveOut: true,
			shade: 0.8,
			area: ['1500px', '80%'],
			content: 'settlement/detial?code='+code
		});		
	}
    </script>
</body>
</html>