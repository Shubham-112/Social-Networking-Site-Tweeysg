package Utilities;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginSecurity {

    public static boolean check(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        } else {
            String user = (String) session.getAttribute("user_email");

            if(session.getAttribute("user_email")==null){
                return false;
            }
        }

        return true;
    }

}
