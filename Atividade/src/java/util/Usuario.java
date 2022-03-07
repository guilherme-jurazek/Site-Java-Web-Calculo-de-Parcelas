
package util;

public class Usuario {
    private String login,senha;

    public Usuario(String login, String senha) {
        this.login = login;
        this.senha = senha;
    }

    public String getLogin() {    return login;   }

    public void setLogin(String login) {   this.login = login;  }

    public String getSenha() {  return senha;   }

    public void setSenha(String senha) {  this.senha = senha;  }
    
    public boolean isValido()
    {   // supondo que a primeira parte é igual a senha
        int i;
        int letras = 0, numeros = 0;
        if(login.length() < 6 || login.length()>8)
            return false;
        if(senha.length() != 4)
            return false;
        for(i = 0 ; i < senha.length() ; i++)
        {    
            if(senha.charAt(i) >= 48 && senha.charAt(i) <= 57)
                numeros += 1;
            if(senha.charAt(i) >= 65 && senha.charAt(i) <= 90)
                letras += 1;
            if(senha.charAt(i) >= 97 && senha.charAt(i) <= 122)
                letras += 1;
        }    
        return !(letras == 0 || numeros == 0);
    }    
}

