import Beans.PostBean;
import Beans.UserBean;
import DAOs.PostDAO;
import DAOs.UserDAO;
import Utilities.LoginSecurity;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@WebServlet(name = "Profile", urlPatterns = {"/profile"})
public class Profile extends HttpServlet {


    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 10 * 1024 * 1024;
    private int maxMemSize = 4 * 1024;
    private File file ;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(!LoginSecurity.check(request, response)){
            request.getRequestDispatcher("/login").forward(request, response);
        }


        PrintWriter pw = response.getWriter();

        String relativeWebPath = "/src/resources/users";
        String relativeStore = "src\\resources\\users";
        String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
        pw.println(absoluteDiskPath);


        isMultipart = ServletFileUpload.isMultipartContent(request);

        HttpSession session = request.getSession();
        UserBean user  = (UserBean) session.getAttribute("user");
        int user_id = user.getId();

        Date date = new Date();
        long time = date.getTime();

        response.setContentType("text/html");


        String cover = "" ;
        String display = "";
        String path = "";
        String first_name = "";
        String last_name = "";

        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString();
                    if(fieldName.equals("first_name")){
                        first_name = fieldValue;
                    }else if(fieldName.equals("last_name")){
                        last_name = fieldValue;
                    }
                }else{
                    File directory = new File(absoluteDiskPath + "\\" + user_id);
                    directory.mkdir();
                    pw.println("can upload");
                    DiskFileItemFactory factory = new DiskFileItemFactory();

                    factory.setSizeThreshold(maxFileSize);
                    factory.setRepository(new File("c:\\temp"));

                    ServletFileUpload upload = new ServletFileUpload(factory);
                    upload.setFileSizeMax(maxFileSize);

                    String fieldName = item.getFieldName();
                    String fileName = item.getName();
                    String contentType = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();

                    if(fieldName.equals("image")){
                        if( fileName.lastIndexOf("\\") >= 0 ) {
                            file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"))) ;
                            display = relativeStore + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"));
                        } else {
                            file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                            display = relativeStore + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1);
                        }
                        item.write( file ) ;
                        pw.println("Uploaded Filename: <>" + fileName);
                    }else if(fieldName.equals("cover")){
                        if( fileName.lastIndexOf("\\") >= 0 ) {
                            file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"))) ;
                            cover = relativeWebPath + "/" + user_id + "/" + time + "-" + fileName.substring( fileName.lastIndexOf("/"));
                        } else {
                            file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                            cover = relativeWebPath + "/" + user_id + "/" + time + "-" + fileName.substring(fileName.lastIndexOf("/")+1);
                        }
                        item.write( file ) ;
                        pw.println("Uploaded Filename: <>" + fileName);
                    }

                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        } catch (Exception e) {
            e.printStackTrace();
        }


        pw.println(cover);
        pw.println(display);
        pw.println(first_name);
        pw.println(last_name);

        UserBean update_user = new UserBean();
        update_user.setFirst_name(first_name);
        update_user.setLast_name(last_name);
        update_user.setDisplay(display);
        update_user.setCover(cover);

        if(UserDAO.updateUser(update_user, user_id)){
            RequestDispatcher view = request.getRequestDispatcher("/dashboard");
            view.forward(request, response);
        }else{
            pw.println("Could'nt update. Please try again !!");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if(!LoginSecurity.check(request, response)){
            request.getRequestDispatcher("/login").forward(request, response);
        }

        PrintWriter pw = response.getWriter();
        String host = request.getHeader("Host");
        if(request.getParameterMap().containsKey("id")){

            request.getRequestDispatcher("WEB-INF/profile.jsp").forward(request, response);

        }else{

            String req_uri = (String) request.getHeader("referer");
            pw.println(req_uri);
            pw.println(host + "/dashboard");
            response.sendRedirect(host);

        }

    }
}
