<%@page import="util.Usuario"%>
<%@page import="util.Conversora"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    
    double montante=1000, juros=10, valorPar, totalJuros;
    int qtd = 5;    
%>


<%  // validação de usuário e registro na sessão
    boolean logado=false;
    Usuario usuario=(Usuario)session.getAttribute("usuario");
    if (usuario!=null) // já foi criado uma sessão
    {   if (usuario!=null && usuario.isValido()) logado=true;
    }
    else
    {   String login=request.getParameter("login");
        String senha=request.getParameter("senha");
        if (login!=null && !login.isEmpty())
        {   usuario=new Usuario(login, senha);
            if (usuario.isValido())
            {   session.setAttribute("usuario", usuario);
                logado=true;
            }                    
        }
    }
    if (!logado)     response.sendRedirect(".");
%>
  


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calcular Divida</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    </head>
    <body>
        
        
        <%
            boolean primeiravez=false;
            try
            {
                montante=Double.parseDouble(request.getParameter("montante"));
                juros=Double.parseDouble(request.getParameter("juros"))/100;
                qtd=Integer.parseInt(request.getParameter("qtd"));
            }
            catch(Exception e)
            {
                 primeiravez = true;
                 //response.sendRedirect(".");
                 
            }
            
            
        %>
        <a href="logout.jsp" style="margin-left: 3%"><img src="back.png" width="40px" ></a>
        <div style="text-align: center">
        <h1>Dados para cálculo:</h1>
        <form action="calculo.jsp"  style="max-width: 40%; margin-left: 30%" >
            <p>Montante Financiado: <input  style="max-width: 40%; margin-left: 30%" class="form-control mb-2 mr-sm-2" type="text" name="montante" value="<%=montante%>" /></p>
            <p>Juros do Financiamento: <input  style="max-width: 40%; margin-left: 30%" class="form-control mb-2 mr-sm-2" type="text" name="juros" value="<%=juros%>"/></p>
            <p>Quantidade de Pracelas: <input style="max-width: 40%; margin-left: 30%"  class="form-control mb-2 mr-sm-2" type="number" name="qtd" value="<%=qtd%>" /></p>
            <p><input type="submit" value="Gerar tabela" class="btn btn-secondary"/></p>
        </form>
            
        </div>    
        <% if(!primeiravez){ %>
        <hr>
        <table border="1" class="table table-dark table-striped">
            <thead>
                <tr> <th>Parcelas</th> <th>Valor da Parcela</th> <th>Amortização</th> <th>Juros</th> <th>Saldo devedor</th>
                </tr>
            </thead>
            <tbody>
                <%  Conversora conv = new Conversora();
                    valorPar = conv.CalcularParcelas(montante, juros, qtd);
                    totalJuros = 0;
                    for (int i=0; i<qtd ; i+=1){  %>
       
                       <tr><td><%= i %></td><td><%= valorPar %></td><td><%= conv.CalcularAmortizacao(montante, juros, valorPar) %></td><td><%= conv.CalcularJuros(montante, juros) %></td><td><%= conv.CalcularSaldoDevedor(montante, juros, valorPar) %></td></tr>
                       <%  totalJuros += conv.CalcularJuros(montante, juros);
                           montante = conv.CalcularSaldoDevedor(montante, juros, valorPar);
                          
                       }%>
            </tbody>
            <tfoot>
                <tr><td style="text-align: center" colspan="5">Total de Juros pago: <%= totalJuros %></td></tr>
            </tfoot>
            
        </table>
        <%}%>

    </body>
</html>
