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
import JavaBeans.Campus;



/**
 *
 * @author Note
 */
public class CampusDao {
    private Connection connection;
    
    public CampusDao(){
        this.connection = new ConnectionFactory().getConnection();
    }
    
     public ArrayList<Campus> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Campus> campus = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from campus");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Campus camp = new Campus();
                
                //Date data =  (Date) alu.getDataNascimento().getTime();
                camp.setIdCampus(rs.getInt("idcampus"));//nome da coluna onde será mostrado 
                camp.setCidade(rs.getString("cidade"));
                camp.setNome(rs.getString("nomeCampus"));
                camp.setIdEstado(rs.getInt("estado_id"));
                
        
                campus.add(camp);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return campus;
    }
}
