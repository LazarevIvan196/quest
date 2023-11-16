<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="services.JsonService" %>
<%@ page import="java.util.Map" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/images/end.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin-top: 250px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <title>"Эпилог"</title>

</head>
<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/startGame" method="post"
          style="text-align: center; margin-top: 250px;">
        <h1>"Эпилог ЗА ЧАС ДО РАССВЕТА..."</h1>
        <p id="stageText">
            <%
                Map<String, Object> stage0Data = JsonService.readJson("/questOne.json");
                if (stage0Data != null) {
                    Object stage0Obj = stage0Data.get("HAPPY_END");
                    if (stage0Obj instanceof Map) {
                        @SuppressWarnings("unchecked")
                        Object stage0TextObj = ((Map<String, Object>) stage0Obj).get("text");
                        if (stage0TextObj instanceof String) {
                            String formattedText = ((String) stage0TextObj).replace("\n", "<br>");
            %>
            <%= formattedText %>
            <%
                        }
                    }
                }
            %>

        <p id="soulsCount">
            <% Integer souls = (Integer) request.getAttribute("souls"); %>
            Количество спасенных душ: <%= (souls != null) ? souls : 0 %>
        </p>
        <div id="questResult"></div>
    </form>
</div>
</body>
</html>
