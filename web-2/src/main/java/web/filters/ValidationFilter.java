package web.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

@WebFilter(urlPatterns = {"/controller", "/checkArea"})
public class ValidationFilter implements Filter {




  private static final String INVALID_DATA_MSG = "Please set the data values in correct form.";



  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    throws IOException, ServletException {
    // Преобразуем запросы и ответы к их HTTP-версиям
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    HttpServletResponse httpResponse = (HttpServletResponse) response;

    // Получаем путь запроса
    String path = httpRequest.getServletPath();

    // Проверяем, нужно ли выполнять валидацию для данного пути
    if ("/controller".equals(path) || "/checkArea".equals(path)) {
      // дуинг валидейшн
      String xParam = request.getParameter("X");
      String yParam = request.getParameter("Y");
      String rParam = request.getParameter("R");

      if (xParam == null || yParam == null || rParam == null ||
        xParam.isEmpty() || yParam.isEmpty() || rParam.isEmpty()) {
        sendError(httpResponse, INVALID_DATA_MSG);
        return;
      }

      try {
        double x = Double.parseDouble(xParam);
        double y = Double.parseDouble(yParam);
        int r = Integer.parseInt(rParam);

        if (x < -4 || x > 4 || y < -3 || y > 5) {
          sendError(httpResponse, INVALID_DATA_MSG);
          return;
        }

        // валидация прошла，牛逼！
        chain.doFilter(request, response);
      } catch (NumberFormatException e) {
        sendError(httpResponse, INVALID_DATA_MSG);
      }
    } else {
      // ну а для остальных запросов продолжаем без валидации
      chain.doFilter(request, response);
    }
  }

  private void sendError(HttpServletResponse response, String errorMessage) throws IOException {
    var json = new Gson();
    Map<String, Object> jsonResponse = new HashMap<>() {{
      put("error", errorMessage);
      put("status", "UNPROCESSABLE_ENTITY");
    }};

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.setStatus(422);
    response.getWriter().write(json.toJson(jsonResponse));
  }


}
