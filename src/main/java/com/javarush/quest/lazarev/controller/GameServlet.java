
package com.javarush.quest.lazarev.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.JsonService;


import java.io.IOException;
import java.util.Map;

public class GameServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        if ("/".equals(servletPath)) {
            request.getRequestDispatcher("/WEB-INF/view/welcome.jsp").forward(request, response);

        } else if ("/quest".equals(servletPath)) {
            Map<String, Object> questData = JsonService.readJson("/questOne.json");
            request.setAttribute("questData", questData);
            request.getRequestDispatcher("/WEB-INF/view/quest.jsp").forward(request, response);

        } else if ("/stage_0".equals(servletPath)) {
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_0.jsp").forward(request, response);

        } else if ("/stage_1".equals(servletPath)) {
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_1.jsp").forward(request, response);

        } else if ("/stage_2".equals(servletPath)) {
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_2.jsp").forward(request, response);

        } else if ("/stage_3".equals(servletPath)) {
            Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
            request.setAttribute("stage3Data", stage3Data);
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            if (souls != null && souls >= 16) {
                souls -= 16;
                request.getSession().setAttribute("souls", souls);
            }
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_3.jsp").forward(request, response);

        } else if ("/stage_4".equals(servletPath)) {
            Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
            request.setAttribute("stage3Data", stage3Data);
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            if (souls != null && souls >= 12) {
                souls -= 12;
                request.getSession().setAttribute("souls", souls);
            }
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_4.jsp").forward(request, response);

        } else if ("/stage_5".equals(servletPath)) {
            Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
            request.setAttribute("stage3Data", stage3Data);
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            if (souls != null && souls >= 12) {
                souls -= 12;
                request.getSession().setAttribute("souls", souls);
            }
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_5.jsp").forward(request, response);
        } else if ("/stage_6".equals(servletPath)) {
        Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
        request.setAttribute("stage3Data", stage3Data);
        Integer souls = (Integer) request.getSession().getAttribute("souls");
        if (souls != null && souls >= 41) {
            souls -= 41;
            request.getSession().setAttribute("souls", souls);
        }
        request.setAttribute("souls", souls);
        request.getRequestDispatcher("/WEB-INF/view/stage_6.jsp").forward(request, response);
        } else if ("/stage_7".equals(servletPath)) {
            Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
            request.setAttribute("stage3Data", stage3Data);
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            if (souls != null && souls >= 13) {
                souls -= 13;
                request.getSession().setAttribute("souls", souls);
            }
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_7.jsp").forward(request, response);
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/stage_6.jsp").forward(request, response);

        } else if ("/happy_end".equals(servletPath)) {
            Map<String, Object> stage3Data = JsonService.readJson("/questOne.json");
            request.setAttribute("stage3Data", stage3Data);
            Integer souls = (Integer) request.getSession().getAttribute("souls");
            if (souls != null && souls >= 42) {
                souls -= 42;
                request.getSession().setAttribute("souls", souls);
            }
            request.setAttribute("souls", souls);
            request.getRequestDispatcher("/WEB-INF/view/happy_end.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String playerName = request.getParameter("playerName");
        request.getSession().setAttribute("playerName", playerName);
        String servletPath = request.getServletPath();

        if ("one".equals(request.getParameter("action"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String json = "{\"message\":\"Переход на уровень 1\",\"redirectToStage\": true}";
            response.getWriter().write(json);
            return;
        }

        if ("two".equals(request.getParameter("action"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String json = "{\"message\":\"Переход на уровень 2\",\"redirectToStage\": true}";
            response.getWriter().write(json);
            return;
        }
        if ("true".equals(request.getParameter("acceptQuest"))) {
            Integer currentSouls = (Integer) request.getSession().getAttribute("souls");

            if (currentSouls == null) {
                currentSouls = 111;
                request.getSession().setAttribute("souls", currentSouls);
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String json = "{\"message\":\"Квест принят!\",\"redirectToStage0\": true}";
            response.getWriter().write(json);
            return;
        }

        if ("true".equals(request.getParameter("restart"))) {

            request.getSession().removeAttribute("playerName");
            request.getSession().removeAttribute("souls");


            request.getSession().setAttribute("souls", 111);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            String json = "{\"redirectToWelcome\": true}";
            response.getWriter().write(json);
            return;
        }

        if ("/quest".equals(servletPath)) {
            Map<String, Object> questData = JsonService.readJson("/questOne.json");
            request.setAttribute("questData", questData);
            request.getRequestDispatcher("/WEB-INF/view/quest.jsp").forward(request, response);
        }
    }
}
