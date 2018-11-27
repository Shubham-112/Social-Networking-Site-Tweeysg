import Beans.PostBean;
import Beans.UserBean;
import DAOs.PostDAO;
import DAOs.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "Dashboard", urlPatterns = {"/dashboard"})
public class Dashboard extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter pw = response.getWriter();
        pw.println("in post dashboard");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user_email");

        pw.println(email);

        UserBean user = UserDAO.getUser(email);

        List<PostBean> posts= PostDAO.getPosts(user.getId());

        pw.println(user.getLast_name());

        for(PostBean post : posts){
            pw.println(post.getBody());
        }

        session.setAttribute("user", user);
        session.setAttribute("posts", posts);
        request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request, response);

    }
}
