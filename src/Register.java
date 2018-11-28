import Beans.UserBean;
import DAOs.UserDAO;
import Utilities.HashPassword;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet(name = "Register", urlPatterns = {"/register"})
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");
        String first_name = request.getParameter("first_name");
        String password = request.getParameter("pass");
        String last_name = request.getParameter("last_name");

        String hashPass = HashPassword.hashPassword(password);

        pw.println(email);
        pw.println(first_name);
        pw.println(last_name);
        pw.println(password);
        pw.println(hashPass);

        UserBean bean = new UserBean();
        bean.setEmail(email);
        bean.setFirst_name(first_name);
        bean.setLast_name(last_name);
        bean.setPassword(hashPass);

        UserDAO Register = new UserDAO();
        if(UserDAO.register(bean)){
            request.getRequestDispatcher("/login").forward(request, response);
        }else{
            pw.println("Error occured !!");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
    }
}
