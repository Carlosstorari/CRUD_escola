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
import JavaBeans.Curso;

/**
 *
 * @author Note
 */
public class CursoDao {
    private Connection connection;
    
    public CursoDao(){
        this.connection = new ConnectionFactory().getConnection();
    }
    
     public ArrayList<Curso> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Curso> curso = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from curso");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Curso curs = new Curso();
                
                //Date data =  (Date) alu.getDataNascimento().getTime();
                curs.setId(rs.getInt("idcurso"));//nome da coluna onde será mostrado 
                curs.setNome(rs.getString("nomecurso"));
                curs.setAnoInicio(rs.getInt("anoinicio"));
                curs.setMesInicio(rs.getString("mesinicio"));
                curs.setIdCoordenador(rs.getString("coordenador"));
                
        
                curso.add(curs);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return curso;
    }
}
