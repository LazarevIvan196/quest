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
            background-image: url('${pageContext.request.contextPath}/images/prologue.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <title>Пролог...</title>
    <script>
        function acceptQuest() {
            fetch("${pageContext.request.contextPath}/startGame", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'playerName=' + encodeURIComponent('${param.playerName}') + '&acceptQuest=true',
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('questResult').innerHTML = data.message;

                    if (data.redirectToStage0) {
                        window.location.href = "${pageContext.request.contextPath}/stage_0";
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

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
    <form action="${pageContext.request.contextPath}/startGame" method="post" style="text-align: center;">
        <h1>Пролог...</h1>
        <p>Добро пожаловать,
            <c:choose>
                <c:when test="${empty sessionScope.playerName or sessionScope.playerName eq ''}">
                    Гость!
                    <br> (Мог бы и потратить пару секунд и ввести имя...)
                    <br>
                </c:when>
                <c:otherwise>
                    <br>${sessionScope.playerName}!
                </c:otherwise>
            </c:choose>
            <br>Это начало твоего приключения!</p>

        <p id="prologueText">
            <%
                Map<String, Object> prologueData = JsonService.readJson("/questOne.json");
                if (prologueData != null) {
                    Object prologueObj = prologueData.get("prologue");
                    if (prologueObj instanceof Map) {
                        @SuppressWarnings("unchecked")
                        Object prologueTextObj = ((Map<String, Object>) prologueObj).get("text");
                        if (prologueTextObj instanceof String) {
                            String formattedText = ((String) prologueTextObj).replace("\n", "<br>");
            %>
            <%= formattedText %>
            <%
                        }
                    }
                }
            %>
        </p>

        <div class="button" style="display: flex; justify-content: space-between; margin-top: 10px;">
            <button type="button" onclick="acceptQuest()">Принять квест</button>
            <button type="button" onclick="restartGame()">Рестарт</button>
        </div>
        <p id="soulsCount">
            <% Integer souls = (Integer) request.getAttribute("souls"); %>
            Количество душ: <%= (souls != null) ? souls : 0 %>
        </p>
        <div id="questResult"></div>
    </form>
</div>
</body>
</html>