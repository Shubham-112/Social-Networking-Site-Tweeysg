import Beans.UserBean;
import DAOs.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Friend", urlPatterns = {"/friend"})
public class Friend extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter pw = response.getWriter();
        HttpSession session = request.getSession();
        UserBean user  = (UserBean) session.getAttribute("user");
        int user_id = user.getId();
        String tp = request.getParameter("to");
        pw.println(tp);
        int reqTo = Integer.parseInt(tp);
        if(UserDAO.sendRequest(reqTo, user_id)){
            String host = request.getHeader("Host");
            response.sendRedirect(host);
        }else{
            pw.println("error occured !!");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
