package Utilities;

import org.mindrot.jbcrypt.BCrypt;

public class HashPassword {

    public static String hashPassword(String plainTextPassword){
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    public static boolean checkPass(String plainPassword, String hashedPassword) {
        if (BCrypt.checkpw(plainPassword, hashedPassword))
            return true;
        else
            return false;
    }

}
