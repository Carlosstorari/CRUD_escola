    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabfinal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Note
 */
public class ConnectionFactory {
    public Connection getConnection(){
       try{
           return DriverManager.getConnection("jdbc:mysql://localhost/escola?user=root");
       } catch(SQLException e){
           throw new RuntimeException(e);
       }
    }
}
