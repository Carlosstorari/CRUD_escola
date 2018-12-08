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
public class Boletim {
    private int idBoletim;
    private Alunos nomeAluno;
    private Materia materia;
    private int IdMateria;
    private float media;
    private float precesa;
    private int falta;

    public int getIdMateria() {
        return IdMateria;
    }

    public void setIdMateria(int IdMateria) {
        this.IdMateria = IdMateria;
    }

    public Materia getMateria() {
        return materia;
    }

    public void setMateria(Materia materia) {
        this.materia = materia;
    }

    public int getFalta() {
        return falta;
    }

    public void setFalta(int falta) {
        this.falta = falta;
    }
    
    private String idAluno;

    public float getPrecesa() {
        return precesa;
    }

    public void setPrecesa(float precesa) {
        this.precesa = precesa;
    }

    public Alunos getNomeAluno() {
        return nomeAluno;
    }

    public void setNomeAluno(Alunos nomeAluno) {
        this.nomeAluno = nomeAluno;
    }

    public int getIdBoletim() {
        return idBoletim;
    }

    public void setIdBoletim(int idBoletim) {
        this.idBoletim = idBoletim;
    }

    public float getMedia() {
        return media;
    }

    public void setMedia(float media) {
        this.media = media;
    }

    public String getIdAluno() {
        return idAluno;
    }

    public void setIdAluno(String idAluno) {
        this.idAluno = idAluno;
    }
}
