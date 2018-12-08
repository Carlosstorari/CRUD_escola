/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classesDao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import trabfinal.ConnectionFactory;
import JavaBeans.Campus;
import JavaBeans.Estado;
import JavaBeans.Professor;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import javax.swing.JOptionPane;

/**
 *
 * @author Note
 */
public class ProfessorDao {
    private Connection connection;
    
    public ProfessorDao(){
        this.connection = new ConnectionFactory().getConnection();
    } 
    
    public void adiciona(Professor prof){
        String sql = "insert into  professor"+
                "(matricula, nome, cpf, rg, rua, nasc, cidade, numcasa, telefone, block, estado, campus, adm, senha, email)"+
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, prof.getId());
            stmt.setString(2, prof.getNome());
            stmt.setString(3, prof.getCpf());
            stmt.setString(4, prof.getRg());
            stmt.setString(5, prof.getRua());
            stmt.setDate(6 , new Date(
                    prof.getDataNascimento().getTimeInMillis()));
            stmt.setString(7, prof.getCidade());
            stmt.setString(8, prof.getNumCasa());
            stmt.setString(9, prof.getTelefone());
            stmt.setBoolean(10, prof.isBlock());
            stmt.setInt(11, prof.getIdEstado());
            stmt.setInt(12, prof.getIdCampus());
            stmt.setBoolean(13, prof.isAdm());
            stmt.setString(14, prof.getSenha());
            stmt.setString(15, prof.getEmail());
            
            stmt.execute();
            stmt.close();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
    
    public ArrayList<Professor> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Professor> professor = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from JTprofessor");
            rs = stmt.executeQuery();
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Professor prof = new Professor();
                
                //Date data =  (Date) alu.getDataNascimento().getTime();
                prof.setId(rs.getString("matricula"));//nome da coluna onde será mostrado 
                prof.setNome(rs.getString("professor"));
                prof.setEmail(rs.getString("email"));
                prof.setCpf(rs.getString("cpf"));
                prof.setRg(rs.getString("RG"));
                
                Campus camp = new Campus();
                camp.setNome(rs.getString("nomecampus"));
                prof.setCampus(camp);
                
                Estado est = new Estado();
                est.setUf(rs.getString("uf"));
                prof.setEstado(est);
                
                prof.setCidade(rs.getString("cidade"));
                prof.setRua(rs.getString("rua"));
                prof.setNumCasa(rs.getString("numcasa"));
                prof.setTelefone(rs.getString("telefone"));
                prof.setDataNascimento(toCalendar(rs.getDate("nasc")));
                professor.add(prof);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return professor;
    }
    
    public static Calendar toCalendar(Date date){ 
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(date);
        return cal;
    }
    
     public void update(Professor prof){
        String sql = "update  professor "+
                " set nome = ?, cpf = ?, rg = ?, rua = ?,"+
                " cidade = ?, numcasa = ?, telefone = ?, estado = ?,"+
                " campus = ?, email = ? "+
                " where matricula = ?";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, prof.getNome());
            stmt.setString(2, prof.getCpf());
            stmt.setString(3, prof.getRg());
            stmt.setString(4, prof.getRua());
            stmt.setString(5, prof.getCidade());
            stmt.setString(6, prof.getNumCasa());
            stmt.setString(7, prof.getTelefone());
            stmt.setInt(8, prof.getIdEstado());
            stmt.setInt(9, prof.getIdCampus());
            stmt.setString(10, prof.getEmail());
            stmt.setString(11, prof.getId());
            stmt.execute();
            stmt.close();
        }catch(MySQLIntegrityConstraintViolationException e){
            JOptionPane.showMessageDialog(null, "É necessario apagar os boletins relacionados a este aluno");
        }
        
        catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
     
     
     public void delete(Professor prof){
        String sql = "delete from  professor where matricula = ?";
                
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, prof.getId());
            stmt.execute();
            stmt.close();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
}
