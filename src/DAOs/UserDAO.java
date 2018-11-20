package DAOs;

import Beans.UserBean;

import java.sql.*;
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
        UserBean user = new UserBean();
        try{
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM user WHERE email='" + email + "'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                return user;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        return user;

    }
}
