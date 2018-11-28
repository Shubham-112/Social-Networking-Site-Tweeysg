import Beans.UserBean;
import Connection.ConnectionManager;
import DAOs.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "notifications", urlPatterns = {"/notifications"})
public class notifications extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        PrintWriter pw = response.getWriter();
        String action = request.getParameter("action");
        int reqBy = Integer.parseInt(request.getParameter("reqBy"));
        UserBean user  = (UserBean) session.getAttribute("user");
        int user_id = user.getId();
        if(action.equals("Accept")){

            if(UserDAO.acceptRequest(reqBy, user_id)){
                String host = request.getHeader("host");
                String name = request.getServerName();
                String port = Integer.toString(request.getServerPort());
                String site = new String ("http://"+name+":"+port+"/index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }else{
                pw.println("error while handling request");
            }
        }else if(action.equals("Decline")){
            if(UserDAO.declineRequest(reqBy, user_id)){
                String host = request.getHeader("host");
                String name = request.getServerName();
                String port = Integer.toString(request.getServerPort());
                String site = new String ("http://"+name+":"+port+"/index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }else{
                pw.println("error while handling request");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/notifications.jsp").forward(request, response);
    }
}
