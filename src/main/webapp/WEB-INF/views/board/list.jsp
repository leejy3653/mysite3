<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/board.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="content">
			<div id="board">
				<form id="search_form"
					action="${pageContext.servletContext.contextPath }/board?a=searchselect"
					method="post">
					<input type="text" id="kwd" name="kwd" value=""> <input
						type="submit" value="찾기">
				</form>
				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>
					<c:forEach items="${list }" var="vo" varStatus="status">
						<tr>
							<td>${count-((page-1)*board_count)-status.index }</td>
							<td class="left" style="padding-left:${15*vo.depth }px;"><c:if
									test="${vo.depth !=0 }">
									<img
										src="${pageContext.servletContext.contextPath }/assets/images/reply.png">
								</c:if> <a
								href="${pageContext.servletContext.contextPath }/board?a=view&g_no=${vo.g_no }&o_no=${vo.o_no }&depth=${vo.depth }&user_no=${vo.user_no }&page=${page }">${vo.title }</a></td>

							<td>${vo.username }</td>
							<td>${vo.hit }</td>
							<td>${vo.reg_Date }</td>
							<td>
							<c:if test="${vo.getUser_no() == authUser.getNo() }">
									<a
										href="${pageContext.servletContext.contextPath }/board?a=delete&no=${vo.no }"
										class="del"> 삭제 </a>
										</c:if>
								</td>
						</tr>
					</c:forEach>
				</table>

				<!-- pager 추가 -->
				<c:if test="${kwd == null }">

					<div class="pager">
						<ul>
							<c:choose>
								<c:when test="${start_page==1 }">
									<li>◀</li>
								</c:when>
								<c:when test="${start_page!=1 }">
									<li><a
										href="${pageContext.servletContext.contextPath }/board?a=select&page=${start_page-size_page }">◀</a></li>
								</c:when>
							</c:choose>
							<c:forEach var="i" begin="${start_page }" end="${end_page }"
								step="1">
								<c:choose>
									<c:when test="${page == i }">
										<li class="selected"><a
											href="${pageContext.servletContext.contextPath }/board?a=select&page=${i }">${i }</a></li>
									</c:when>
									<c:when test="${(page != i) and (total_page>=i) }">
										<li><a
											href="${pageContext.servletContext.contextPath }/board?a=select&page=${i }">${i }</a></li>
									</c:when>
									<c:otherwise>
										<li>${i }</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${end_page<total_page && size_page<total_page }">
									<li><a
										href="${pageContext.servletContext.contextPath }/board?a=select&page=${start_page+size_page }">▶</a></li>
								</c:when>
								<c:otherwise>
									<li>▶</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</c:if>
				<c:if test="${kwd != null }">
					<div class="pager">
						<ul>
							<c:choose>
								<c:when test="${start_page==1 }">
									<li>◀</li>
								</c:when>
								<c:when test="${start_page!=1 }">
									<li><a
										href="${pageContext.servletContext.contextPath }/board?a=searchselect&page=${start_page-size_page }&kwd=${kwd }">◀</a></li>
								</c:when>
							</c:choose>
							<c:forEach var="i" begin="${start_page }" end="${end_page }"
								step="1">
								<c:choose>
									<c:when test="${page == i }">
										<li class="selected"><a
											href="${pageContext.servletContext.contextPath }/board?a=searchselect&page=${i }&kwd=${kwd }">${i }</a></li>
									</c:when>
									<c:when test="${(page != i) and (total_page>=i) }">
										<li><a
											href="${pageContext.servletContext.contextPath }/board?a=searchselect&page=${i }&kwd=${kwd }">${i }</a></li>
									</c:when>
									<c:otherwise>
										<li>${i }</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${end_page<total_page && size_page<total_page }">
									<li><a
										href="${pageContext.servletContext.contextPath }/board?a=searchselect&page=${start_page+size_page }&kwd=${kwd }">▶</a></li>
								</c:when>
								<c:otherwise>
									<li>▶</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</c:if>
				<!-- pager 추가 -->



				<div class="bottom">
					<c:if test="${not empty authUser }">
						<a
							href="${pageContext.servletContext.contextPath }/board?a=writeAdd&user_no=${authuser.no }"
							id="new-book">글쓰기</a>
					</c:if>
				</div>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="board" />
		</c:import>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>