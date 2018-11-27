import Beans.PostBean;
import Beans.UserBean;
import Connection.ConnectionManager;
import DAOs.PostDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "Post", urlPatterns = {"/post"})
@MultipartConfig
public class Post extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 10 * 1024 * 1024;
    private int maxMemSize = 4 * 1024;
    private File file ;


    public void init(){
        filePath = getServletContext().getInitParameter("file-upload");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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


        String body = "" ;
        String path = "";

        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString();
                    if(fieldName.equals("postBody")){
                        body = fieldValue;
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

                    if( fileName.lastIndexOf("\\") >= 0 ) {
                        file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"))) ;
                        path = relativeStore + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"));
                    } else {
                        file = new File( absoluteDiskPath + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                        path = relativeStore + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1);
                    }
                    item.write( file ) ;
                    pw.println("Uploaded Filename: <>" + fileName);
                }
            }
        } catch (FileUploadException e) {
            throw new ServletException("Cannot parse multipart request.", e);
        } catch (Exception e) {
            e.printStackTrace();
        }


        PostBean post = new PostBean();
        post.setUserId(user_id);
        post.setBody(body);
        post.setLink(path);


        if(PostDAO.AddPost(post)){
            RequestDispatcher view = request.getRequestDispatcher("/dashboard");
            view.forward(request, response);
        }else{
            pw.println("Could'nt upload. Please try again !!");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
