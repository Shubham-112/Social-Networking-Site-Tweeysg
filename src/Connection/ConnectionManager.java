package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {
    static Connection conn;

    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }

        try{
            conn = DriverManager.getConnection("jdbc:mysql://localhost/tweeysg", "root", "root");

        }catch (SQLException e){
            e.printStackTrace();
        }
        return conn;
    }
}
