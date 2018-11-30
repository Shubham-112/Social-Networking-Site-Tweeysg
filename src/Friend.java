import Beans.UserBean;
import Connection.ConnectionManager;
import DAOs.UserDAO;
import Utilities.LoginSecurity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "Friend", urlPatterns = {"/friend"})
public class Friend extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(!LoginSecurity.check(request, response)){
            request.getRequestDispatcher("/login").forward(request, response);
        }

        PrintWriter pw = response.getWriter();
        HttpSession session = request.getSession();
        UserBean user  = (UserBean) session.getAttribute("user");
        int user_id = user.getId();
        String tp = request.getParameter("to");
        pw.println(tp);
        int reqTo = Integer.parseInt(tp);
        pw.println(reqTo);
        pw.println(user_id);

        if(UserDAO.sendRequest(reqTo, user_id)){
            String host = request.getHeader("host");
            String name = request.getServerName();
            String port = Integer.toString(request.getServerPort());
            String site = new String ("http://"+name+":"+port+"/index.jsp");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
            pw.println(site);
            pw.println(name);
            pw.println(port);
        }else{
            pw.println("error occured !!");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
