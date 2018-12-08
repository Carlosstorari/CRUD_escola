/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JavaBeans;

/**
 *
 * @author Note
 */
public class Alunos extends Usuario {
   
    private int IdCurso;
    private Curso curso;

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public int getIdCurso() {
        return IdCurso;
    }

    public void setIdCurso(int curso) {
        this.IdCurso = curso;
    }

    @Override
    public String toString() {
        return super.getNome()+" / Id: "+getId(); //To change body of generated methods, choose Tools | Templates.
    }
   
   
}
