# Projeto_Integrador_Senac
IMPLEMENTAÇÃO BANCO DE DADOS PARA MERCADO  -  SQL SERVER, COM MANAGEMENT STUDIO. 

RESUMO DOS DOIS PROJETOS:
Nesse meu primeiro projeto(Trigger de Auditoria) faço o cadastro de todos produtos de um mercado, bem como as atualizações e exclusões necessárias do dia-a-dia. Nesse projeto em especial, minha proposta foi a criação de uma Trigger/Gatilho que é disparado automaticamente toda vez que em funcionário fizer uma alteração no campo "PREÇO" da tabela "PRODUTO", ou seja,  ele alimenta "detalhadamente" uma tabela que está dentro do banco "DIRETORIA" alertando que houve alteração em preços, para que o gerente tenha conhecimento de tal. Outros tipos de alterações 'não relevantes' são processadas normalmente, porém não são alimentadas no banco "DIRETORIA". 
Obs.: Vide tabela com as referidas execuções, disponibilizada aqui no projeto.

No meu segundo projeto (Aumento de Salário) faço o cadastro de todos funcionários do mercado, bem como as atualizações/exclusões que forem necessárias no período contratual. Minha proposta, em especial nesse projeto,  foi a criação de uma Trigger/Gatilho que é disparado automaticamente toda vez que o Departamento de Recursos Humanos fizer uma alteração no campo "SALÁRIO" da tabela "EMPREGADOS", ou seja,  ele alimenta "detalhadamente" uma tabela que está dentro do banco "DIRETORIA" alertando que houve alteração de salário, para que o gerente tenha conhecimento de tal. Outros tipos de alterações 'não relevantes' são processadas normalmente, porém não são alimentadas no banco "DIRETORIA". Outro ponto também  importante neste projeto é que criei uma segunda Trigger/Gatilho, que controla se a inclusão/alteração de salário está entre o "piso mínimo" e "teto máximo" definidos na tabela "PISO_TETO_SALARIO", caso não, o gatilho bloqueia e interrompe automaticamente a operação, disparando o devido aviso ao usuário.
Obs.: Vide tabela com as referidas execuções, disponibilizada aqui no projeto.

OBSERVAÇÃO IMPORTANTE: Em ambos os projetos, quando disparados os gatilhos para o banco DIRETORIA, o sistema captura a "data hora" e "nome do usuário" responsável pela operação, incluindo-os na referida tabela.
 
