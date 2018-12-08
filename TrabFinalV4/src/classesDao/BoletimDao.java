/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classesDao;

import JavaBeans.Alunos;
import JavaBeans.Boletim;
import JavaBeans.Materia;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import trabfinal.ConnectionFactory;

/**
 *
 * @author Note
 */
public class BoletimDao {
 private Connection connection;
 
 
    
    public BoletimDao(){
        this.connection = new ConnectionFactory().getConnection();
    }   
    
    public void adiciona(Boletim boletim){
        String sql = "insert into  boletim"+
                "(idboletim, media, faltas, aluno)"+
                "values(?, ?, ?, ?)";
        String sql2 = "insert into  boletim_has_materia"+
                "(boletim_idboletim, materia_idmateria)"+
                "values(?, ?)";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            PreparedStatement stmt2 = connection.prepareStatement(sql2);
            
            stmt.setInt(1, boletim.getIdBoletim());
            stmt.setFloat(2, boletim.getMedia());
            stmt.setInt(3, boletim.getFalta());
            stmt.setString(4, boletim.getIdAluno());
            
            stmt.execute();
            stmt.close();
            
            stmt2.setInt(1, boletim.getIdBoletim());
            stmt2.setInt(2, boletim.getIdMateria());
            
            stmt2.execute();
            stmt2.close();
                        
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

 public ArrayList<Boletim> read(String matri){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Boletim> boletim = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select aluno.nome as 'Aluno', nomemateria as 'Matéria', (80-faltas)*1.25 as 'Presença(%)', media as 'Média' from boletim inner join aluno on boletim.aluno=aluno.matricula inner join boletim_has_materia on boletim_idboletim=idboletim inner join materia on idmateria=materia_idmateria where aluno.matricula = ?");
            stmt.setString(1, matri);
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Boletim bole = new Boletim();
                
                Alunos alu = new Alunos();
                alu.setNome(rs.getString("Aluno"));
                bole.setNomeAluno(alu);
                
                Materia mat = new Materia();
                mat.setNome(rs.getString("Matéria"));
                bole.setMateria(mat);
                
                bole.setPrecesa(rs.getFloat("presença(%)"));//nome da coluna onde será mostrado 
                bole.setMedia(rs.getFloat("média"));
                
                boletim.add(bole);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return boletim;
    }
 
 public ArrayList<Boletim> read2(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Boletim> boletim = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from jTableAlteraBoletim");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Boletim bole = new Boletim();
                bole.setIdBoletim(rs.getInt("idBoltim"));
                bole.setMedia(rs.getFloat("media"));
                bole.setFalta(rs.getInt("fatas"));
                
                Alunos alu = new Alunos();
                alu.setNome(rs.getString("aluno"));
                bole.setNomeAluno(alu);
                
                Materia mat = new Materia();
                mat.setNome(rs.getString("materia"));
                bole.setMateria(mat);
                
                
                
                boletim.add(bole);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return boletim;
    }
 
 
     public void update(Boletim bole){
        String sql = "update  boletim "+
                " set faltas = ?, media = ? "+
                " where idboletim = ?";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setInt(1, bole.getFalta());
            stmt.setFloat(2, bole.getMedia());
            stmt.setInt(3, bole.getIdBoletim());
            
            stmt.execute();
            stmt.close();
        }catch(MySQLIntegrityConstraintViolationException e){
            JOptionPane.showMessageDialog(null, "É necessario apagar os boletins relacionados a este aluno");
        }
        
        catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
     
     public void delete(Boletim bole){
        String sql = "delete from  boletim where idboletim = ?";
                
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setInt(1, bole.getIdBoletim());
            stmt.execute();
            stmt.close();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
     
}
