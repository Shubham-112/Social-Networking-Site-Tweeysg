package DAOs;

import Beans.UserBean;

import java.sql.*;
import java.text.SimpleDateFormat;

import Connection.ConnectionManager;
import Utilities.HashPassword;

public class UserDAO {
    static Connection conn = null;
    static ResultSet rs = null;

    public static boolean register(UserBean bean){

        String first_name = bean.getFirst_name();
        String last_name = bean.getLast_name();
        String email = bean.getEmail();
        String password = bean.getPassword();

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO user(first_name, last_name, email, password) VALUE(?,?,?,?)");
            stmt.setString(1, first_name);
            stmt.setString(2, last_name);
            stmt.setString(3, email);
            stmt.setString(4, password);
            int i = stmt.executeUpdate();
            if(i>0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;

    }

    public static boolean LoginCheck(UserBean bean){
        String email = bean.getEmail();
        String password = bean.getPassword();

        try {
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM user WHERE email='" + email + "'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                String stored_pass = rs.getString("password");
                if(HashPassword.checkPass(password, stored_pass)){
                    return true;
                }else{
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;

    }

    public static UserBean getUser(String email){
        UserBean user = null;
        try{
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM user WHERE email='" + email + "'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                user.setCover(rs.getString("cover"));
                user.setDisplay(rs.getString("display"));
                return user;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        return user;

    }

    public static boolean updateUser(UserBean user, int id){
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("UPDATE user SET first_name=?, last_name=?, cover=?, display=? WHERE id="+ id +"");
            stmt.setString(1, user.getFirst_name());
            stmt.setString(2, user.getLast_name());
            stmt.setString(3, user.getCover());
            stmt.setString(4, user.getDisplay());
            int i = stmt.executeUpdate();
            if(i>0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static boolean sendRequest(int reqTo, int user){
        Connection conn;
        try{
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM friendrequests WHERE requestBy=" + user + " AND requestTo=" + reqTo + "";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if(!rs.next()){
                Connection newC = ConnectionManager.getConnection();
                PreparedStatement insstmt = newC.prepareStatement("INSERT INTO friendrequests(requestBy, requestTo) VALUE(?,?)");
                insstmt.setInt(1, user);
                insstmt.setInt(2, reqTo);
                int t = insstmt.executeUpdate();
                if(t>0){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public static boolean acceptRequest(int reqBy, int user){
        try{
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM friendrequests WHERE requestBy=" + reqBy + " AND requestTo=" + user + "";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if(rs.next()){
                Connection newC = ConnectionManager.getConnection();
                PreparedStatement insstmt = newC.prepareStatement("UPDATE friendrequests SET status='accepted' WHERE requestBy=? AND requestTo=?");
                insstmt.setInt(1, reqBy);
                insstmt.setInt(2, user);
                int t = insstmt.executeUpdate();
                if(t>0){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }


    public static boolean declineRequest(int reqBy, int user){
        try{
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM friendrequests WHERE requestBy=" + reqBy + " AND requestTo=" + user + "";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            if(rs.next()){
                Connection newC = ConnectionManager.getConnection();
                PreparedStatement insstmt = newC.prepareStatement("UPDATE friendrequests SET status='rejected' WHERE requestBy=? AND requestTo=?");
                insstmt.setInt(1, reqBy);
                insstmt.setInt(2, user);
                int t = insstmt.executeUpdate();
                if(t>0){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }

}
