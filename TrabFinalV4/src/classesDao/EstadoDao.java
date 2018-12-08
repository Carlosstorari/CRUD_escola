/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classesDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import trabfinal.ConnectionFactory;
import JavaBeans.Estado;

/**
 *
 * @author Note
 */
public class EstadoDao {
    
    private Connection connection;
    
    public EstadoDao(){
        this.connection = new ConnectionFactory().getConnection();
    }
    
    public ArrayList<Estado> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Estado> estado = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from estado");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Estado est = new Estado();
                
                
                est.setId(rs.getInt("id"));
                est.setUf(rs.getString("UF"));
                
                
        
                estado.add(est);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return estado;
    }
}
