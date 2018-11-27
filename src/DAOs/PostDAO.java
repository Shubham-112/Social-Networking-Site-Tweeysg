package DAOs;

import Beans.PostBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Beans.UserBean;
import Connection.ConnectionManager;

public class PostDAO {

    static Connection conn = null;
    static ResultSet rs = null;

    public static boolean AddPost(PostBean post){

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO posts(postBody, userId, mediaLink) VALUE(?,?,?)");
            stmt.setString(1, post.getBody());
            stmt.setInt(2, post.getUserId());
            stmt.setString(3, post.getLink());
            int i = stmt.executeUpdate();
            if(i>0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static List<PostBean> getPosts(int user){
        List<PostBean> posts = null ;
        try {
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM posts WHERE userId = '" + user +"' ORDER BY createdAt DESC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            posts = new ArrayList<PostBean>() ;

            while(rs.next()){
                PostBean post = new PostBean();
                post.setBody(rs.getString("postBody"));
                post.setLink(rs.getString("mediaLink"));
                post.setDate(rs.getString("createdAt"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;

    }
}
