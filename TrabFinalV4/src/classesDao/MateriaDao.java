/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classesDao;

import JavaBeans.Materia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import trabfinal.ConnectionFactory;

/**
 *
 * @author Note
 */
public class MateriaDao {
private Connection connection;
    
    public MateriaDao(){
        this.connection = new ConnectionFactory().getConnection();
    }
    
    public ArrayList<Materia> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Materia> materia = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from materia");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Materia mat = new Materia();
                
                
                mat.setId(rs.getInt("idmateria"));
                mat.setNome(rs.getString("nomemateria"));
                mat.setIdCurso(rs.getInt("curso"));
                mat.setIdProfessor(rs.getInt("professor"));
                
                
                
        
                materia.add(mat);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return materia;
    }    
}
