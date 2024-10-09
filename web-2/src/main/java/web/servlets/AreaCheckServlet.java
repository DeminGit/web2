package web.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.google.gson.Gson;
import web.daos.PointDao;
import web.models.Point;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

// Обрабатывает запросы на проверку точки. В зависимости от параметра action,
// либо перенаправляет на JSP-страницу с результатом, либо возвращает JSON-ответ

@WebServlet("/checkArea")
public class AreaCheckServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }

  private void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    try {
      double x = Double.parseDouble(request.getParameter("X"));
      double y = Double.parseDouble(request.getParameter("Y"));
      int r = Integer.parseInt(request.getParameter("R"));
      Point point = new Point(x, y, r);

      // Получаем Bean из сессии
      HttpSession session = request.getSession();
      PointDao bean = (PointDao) session.getAttribute("pointDao");
      if (bean == null) {
        bean = new PointDao();
        session.setAttribute("pointDao", bean);
      }
      bean.addPoint(point);

      String action = request.getParameter("action");
      if ("submitForm".equals(action)) {
        request.setAttribute("X", x);
        request.setAttribute("Y", y);
        request.setAttribute("R", r);
        request.setAttribute("result", point.isInArea());

        RequestDispatcher dispatcher = request.getRequestDispatcher("./result.jsp");
        dispatcher.forward(request, response);

      } else if ("checkPoint".equals(action)) {
        Gson gson = new Gson();
        Map<String, Object> json = new HashMap<>();
        json.put("x", x);
        json.put("y", y);
        json.put("r", r);
        json.put("result", point.isInArea());
        String msg = gson.toJson(json);

        response.setContentType("application/json");
        response.getWriter().write(msg);
      }
    } catch (Exception e) {
      // Обработка исключений (например, перенаправление на ошибку)
      request.getRequestDispatcher("./index.jsp").forward(request, response);
    }
  }
}
