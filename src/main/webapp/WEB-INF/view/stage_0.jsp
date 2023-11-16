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
            background-image: url('${pageContext.request.contextPath}/images/stage_0.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin-top: 100px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <title>Уровень 0</title>
    <script>
        function handleActionOne() {
            fetch("${pageContext.request.contextPath}/startGame", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'playerName=' + encodeURIComponent('${param.playerName}') + '&action=one',
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('questResult').innerHTML = data.message;

                    if (data.redirectToStage) {
                        window.location.href = "${pageContext.request.contextPath}/stage_1";
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function handleActionTwo() {
            fetch("${pageContext.request.contextPath}/startGame", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'playerName=' + encodeURIComponent('${param.playerName}') + '&action=two',
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('questResult').innerHTML = data.message;

                    if (data.redirectToStage) {
                        window.location.href = "${pageContext.request.contextPath}/stage_2";
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function goBack() {
            window.history.back();
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
    <form action="${pageContext.request.contextPath}/startGame" method="post"
          style="text-align: center; margin-top: 100px;">
        <h1>Уровень 0 КОНЕЧНАЯ...</h1>
        <p id="stageText">
            <%
                Map<String, Object> stage0Data = JsonService.readJson("/questOne.json");
                if (stage0Data != null) {
                    Object stage0Obj = stage0Data.get("STAGE_0");
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
            <button type="button" onclick="handleActionOne()">Собрать вещи и отправиться на поиски убежища</button>
            <button type="button" onclick="handleActionTwo()">Отправить разведчиков</button>
            <button type="button" onclick="goBack()">Назад</button>
            <button type="button" onclick="restartGame()">Рестарт</button>
        </div>
        <p id="soulsCount">
            <% Integer souls = (Integer) request.getAttribute("souls"); %>
            Количество выживших душ: <%= (souls != null) ? souls : 0 %>
        </p>
        <div id="questResult"></div>
    </form>
</div>
</body>
</html>
