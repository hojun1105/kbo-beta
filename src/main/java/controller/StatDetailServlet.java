package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

import model.PlayerStat;

@WebServlet("/stat-detail")
public class StatDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<PlayerStat> stats = new ArrayList<>();
        stats.add(new PlayerStat("2023", "LG", 0.313, 139, 583, 520, 87, 163, 29, 4, 23, 269, 95, 7, 3, 53, 75, 0.517, 0.376));

        request.setAttribute("playerStats", stats);
        request.getRequestDispatcher("/views/stat_detail.jsp").forward(request, response);
    }
}

