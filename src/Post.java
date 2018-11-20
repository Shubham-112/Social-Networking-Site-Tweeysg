import Beans.PostBean;
import Beans.UserBean;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "Post", urlPatterns = {"/post"})
public class Post extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 50 * 1024;
    private int maxMemSize = 4 * 1024;
    private File file ;


    public void init(){
        filePath = getServletContext().getInitParameter("file-upload");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        isMultipart = ServletFileUpload.isMultipartContent(request);

        HttpSession session = request.getSession();
        UserBean user  = (UserBean) session.getAttribute("user");
        int user_id = user.getId();

        Date date = new Date();
        long time = date.getTime();

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String path = "";

        if(!isMultipart){
            pw.println("cannot upload !!");
        }else{
            File directory = new File(filePath + "\\" + user_id);
            directory.mkdir();
            pw.println("can upload");
            DiskFileItemFactory factory = new DiskFileItemFactory();

            factory.setSizeThreshold(maxFileSize);
            factory.setRepository(new File("c:\\temp"));

            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(maxFileSize);

            try{
                List fileItems = upload.parseRequest(request);
                Iterator i = fileItems.iterator();

                while(i.hasNext()){
                    FileItem fi = (FileItem)i.next();
                    if(!fi.isFormField()){
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        String contentType = fi.getContentType();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();

                        if( fileName.lastIndexOf("\\") >= 0 ) {
                            file = new File( filePath + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"))) ;
                            path = filePath + "\\" + user_id + "\\" + time + "-" + fileName.substring( fileName.lastIndexOf("\\"));
                        } else {
                            file = new File( filePath + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                            path = filePath + "\\" + user_id + "\\" + time + "-" + fileName.substring(fileName.lastIndexOf("\\")+1);
                        }
                        fi.write( file ) ;
                        pw.println("Uploaded Filename: " + fileName);
                    }
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }

        PostBean post = new PostBean();
        post.setUserId(user_id);
        post.setBody(request.getParameter("body"));
        post.setLink(path);
        

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
