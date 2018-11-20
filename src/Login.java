import Beans.UserBean;
import DAOs.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("pass");

        UserBean user = new UserBean();
        user.setEmail(email);
        user.setPassword(password);

        UserDAO Login = new UserDAO();
        if(UserDAO.LoginCheck(user)){
            HttpSession session = request.getSession();
            session.setAttribute("user_email", email);
            pw.println("forwarding request");
            RequestDispatcher view = request.getRequestDispatcher("/dashboard");
            view.forward(request, response);
        }else{
            pw.println("Incorrect Credentials. Please try again !!");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
