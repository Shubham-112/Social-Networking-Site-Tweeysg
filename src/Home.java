import Beans.UserBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Home", urlPatterns = {"/main"})
public class Home extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter pw = response.getWriter();
        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher("/login").forward(request, response);
        } else {
            String user = (String) session.getAttribute("user_email");

            if(session.getAttribute("user_email")!=null){
                request.getRequestDispatcher("/dashboard").forward(request, response);
            }else{
                request.getRequestDispatcher("/login").forward(request, response);
            }
        }

    }
}
