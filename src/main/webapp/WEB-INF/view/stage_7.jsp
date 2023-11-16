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
            background-image: url('${pageContext.request.contextPath}/images/stage_7.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <title>Уровень 7</title>
    <script>

        function restartGame() {
            fetch("${pageContext.request.contextPath}/startGame?restart=true", {
                method: 'POST',
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('questResult').innerHTML = data.message;

                    if (data.redirectToWelcome) {
                        window.location.href = "${pageContext.request.contextPath}/startGame";
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    </script>
</head>
<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/startGame" method="post" style="text-align: center; margin-top: 200px;">
        <h1>Уровень 7 ОГОНЬ и ЛЕД</h1>
        <p id="stageText">
            <%
                Map<String, Object> stage0Data = JsonService.readJson("/questOne.json");
                if (stage0Data != null) {
                    Object stage0Obj = stage0Data.get("STAGE_7");
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
        </p>
        <div class="button" style="display: flex; justify-content: space-between; margin-top: 10px;">

            <button type="button" onclick="restartGame()">Рестарт</button>
        </div>
        <p id="soulsCount">
            <% Integer souls = (Integer) request.getAttribute("souls"); %>
            Количество сгинувших в пламени душ: <%= (souls != null) ? souls : 0 %>
        </p>
        <div id="questResult"></div>
    </form>
</div>
</body>
</html>
