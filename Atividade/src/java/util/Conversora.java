
package util;

import java.text.DecimalFormat;

public class Conversora {
    public double CalcularParcelas(double montante, double juros, int qtdParc)
    { 
        String valor = new DecimalFormat("0.00").format(montante*((juros*Math.pow((juros+1.0),qtdParc))/ (Math.pow((juros+1.0),qtdParc)-1)));
        valor = valor.replace(",", ".");
        return Double.parseDouble(valor);
    }   
    public double CalcularJuros(double montante, double juros)
    {
        String valor = new DecimalFormat("0.00").format(montante*juros);
        valor = valor.replace(",", ".");
        return Double.parseDouble(valor);
    }  
    
    public double CalcularSaldoDevedor(double montante, double juros, double valorPar)
    {
        String valor = new DecimalFormat("0.00").format(montante - (valorPar - montante*juros));
        valor = valor.replace(",", ".");
        if(Double.parseDouble(valor)>=0)
            return Double.parseDouble(valor);
        return 0.00;
    }  
    
     public double CalcularAmortizacao(double montante, double juros, double valorPar)
    {
        String valor = new DecimalFormat("0.00").format(valorPar - juros*montante);
        valor = valor.replace(",", ".");
        return Double.parseDouble(valor);
    }  
}
