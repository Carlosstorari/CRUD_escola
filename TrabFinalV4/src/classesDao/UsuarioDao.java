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
import java.util.logging.Level;
import java.util.logging.Logger;
import trabfinal.ConnectionFactory;
import JavaBeans.Usuario;

/**
 *
 * @author Note
 */
public class UsuarioDao extends Usuario {
    
     public int checkLogin(String login, String senha){
        Connection connection = new ConnectionFactory().getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        int check = 0;
        String[] tabelas = {"aluno", "professor"};
        
        try {
            for(int i =0; i<tabelas.length;i++){
                stmt = connection.prepareStatement("select * from "+tabelas[i]+" where matricula = ? and senha = ?");

                stmt.setString(1, login);
                stmt.setString(2, senha);

                rs = stmt.executeQuery();//guarda os resultados do select no rs
                
                if(rs.next()){
                    if(tabelas[i].equals("professor")){ 
                        check = 1;
                        stmt = connection.prepareStatement("select * from professor where matricula = ? and adm = true");
                        stmt.setString(1, login);
                        rs2 = stmt.executeQuery();//guarda o resultado da segunda query
                        if(rs2.next()){
                            check = 3;
                        }
                    } else if(tabelas[i].equals("aluno")){
                        check = 2;
                    }
                }
            }
            stmt.close();
            rs.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(AlunoDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }
    
}
