/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classesDao;

import JavaBeans.Alunos;
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
import JavaBeans.*;
import static classesDao.AlunoDao.toCalendar;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import javax.swing.JOptionPane;
import trabfinal.ConnectionFactory;

public class AlunoDao {
    private Connection connection;
    
    public AlunoDao(){
        this.connection = new ConnectionFactory().getConnection();
    }   
    /////////////////////////////// INSERE OS DADOS DOS ALUNOS NO BD
    public void adiciona(Alunos aluno){
        String sql = "insert into  aluno"+
                "(matricula, nome, cpf, rg, rua, nasc, cidade, numcasa, telefone, block, estado, campus, curso, senha, email)"+
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, aluno.getId());
            stmt.setString(2, aluno.getNome());
            stmt.setString(3, aluno.getCpf());
            stmt.setString(4, aluno.getRg());
            stmt.setString(5, aluno.getRua());
            stmt.setDate(6 , new Date(
                    aluno.getDataNascimento().getTimeInMillis()));
            stmt.setString(7, aluno.getCidade());
            stmt.setString(8, aluno.getNumCasa());
            stmt.setString(9, aluno.getTelefone());
            stmt.setBoolean(10, aluno.isBlock());
            stmt.setInt(11, aluno.getIdEstado());
            stmt.setInt(12, aluno.getIdCampus());
            stmt.setInt(13, aluno.getIdCurso());
            stmt.setString(14, aluno.getSenha());
            stmt.setString(15, aluno.getEmail());
            
            stmt.execute();
            stmt.close();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
    /////////////////////////////// RETORNA TODOS OS ALUNOS
    public ArrayList<Alunos> read(){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Alunos> aluno = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select * from JTalunos");
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Alunos alu = new Alunos();
                
                //Date data =  (Date) alu.getDataNascimento().getTime();
                alu.setId(rs.getString("ID"));//nome da coluna onde será mostrado 
                alu.setNome(rs.getString("nome"));
                
                Curso curs = new Curso();
                curs.setNome(rs.getString("curso"));
                alu.setCurso(curs);
                
                alu.setEmail(rs.getString("email"));
                alu.setCpf(rs.getString("cpf"));
                alu.setRg(rs.getString("rg"));
                
                Estado est = new Estado();
                est.setUf(rs.getString("UF"));
                alu.setEstado(est);
                
                Campus camp = new Campus();
                camp.setNome(rs.getString("campus"));
                alu.setCampus(camp);
                
                alu.setCidade(rs.getString("cidade"));
                alu.setRua(rs.getString("rua"));
                alu.setNumCasa(rs.getString("numCasa"));
                alu.setTelefone(rs.getString("telefone"));
                alu.setDataNascimento(toCalendar(rs.getDate("nasc")));
                aluno.add(alu);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aluno;
    }
    
    public static Calendar toCalendar(Date date){ 
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(date);
        return cal;
    }
    /////////////////////////////// RETORNA OS DADOS PARA MOSTRAR NA TABELA BOLETIM
    public ArrayList<Boletim> boletimRead(String login){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Boletim> boletim = new ArrayList();
        
        try {
            stmt = connection.prepareStatement("select aluno.nome as 'Aluno', nomemateria as 'Matéria', (80-faltas)*1.25 as 'Presença(%)', media as 'Média' from boletim inner join aluno on boletim.aluno=aluno.matricula inner join boletim_has_materia on boletim_idboletim=idboletim inner join materia on idmateria=materia_idmateria where aluno.matricula = ?");
            stmt.setString(1, login);
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

    //////////////MOSTRA COMBO BOX ALUNO DE ACORDO COM COMBOBOX DE CURSO
    public ArrayList<Alunos> readAlunoPorCurso(Curso itemSelected){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        ArrayList <Alunos> aluno = new ArrayList();
        
        try {
            
            stmt = connection.prepareStatement("select * from aluno where curso = ?");
            stmt.setInt(1, itemSelected.getId());
            rs = stmt.executeQuery();//guarda os resultados do select no rs
            
            while(rs.next()){ //enquanto o select gerar valor, o while será executado
                Alunos alu = new Alunos();
                
                //Date data =  (Date) alu.getDataNascimento().getTime();
                alu.setId(rs.getString("matricula"));//nome da coluna onde será mostrado 
                alu.setNome(rs.getString("nome"));  
                alu.setCpf(rs.getString("cpf"));
                alu.setRg(rs.getString("rg"));
                alu.setRua(rs.getString("rua"));
                alu.setIdCurso(rs.getInt("curso")); 
                alu.setEmail(rs.getString("email"));
                alu.setIdEstado(rs.getInt("estado"));
                alu.setIdCampus(rs.getInt("campus"));
                alu.setCidade(rs.getString("cidade"));
                alu.setNumCasa(rs.getString("numCasa"));
                alu.setTelefone(rs.getString("telefone"));
                alu.setDataNascimento(toCalendar(rs.getDate("nasc")));
                aluno.add(alu);
                
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return aluno;
    }
    
    public void update(Alunos aluno){
        String sql = "update  aluno"+
                " set nome = ?, cpf = ?, rg = ?, rua = ?,"+
                " cidade = ?, numcasa = ?, telefone = ?, estado = ?,"+
                " campus = ?, curso = ?, email = ? "+
                " where matricula = ?";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, aluno.getNome());
            stmt.setString(2, aluno.getCpf());
            stmt.setString(3, aluno.getRg());
            stmt.setString(4, aluno.getRua());
            stmt.setString(5, aluno.getCidade());
            stmt.setString(6, aluno.getNumCasa());
            stmt.setString(7, aluno.getTelefone());
            stmt.setInt(8, aluno.getIdEstado());
            stmt.setInt(9, aluno.getIdCampus());
            stmt.setInt(10, aluno.getIdCurso());
            stmt.setString(11, aluno.getEmail());
            stmt.setString(12, aluno.getId());
            stmt.execute();
            stmt.close();
        }catch(MySQLIntegrityConstraintViolationException e){
            JOptionPane.showMessageDialog(null, "É necessario apagar os boletins relacionados a este aluno");
        }
        
        catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
    
    public void delete(Alunos aluno){
        String sql = "delete from  aluno where matricula = ?";
                
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, aluno.getId());
            stmt.execute();
            stmt.close();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }
    
    
}

