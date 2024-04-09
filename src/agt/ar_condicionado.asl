// Agent gui in project aula10

/* Initial beliefs and rules */

temperatura_de_preferencia(bernardo,24).
temperatura_ambiente(30).

+usuario_suspeito(Suspeito) : true.
+usuario_atual(User) : true.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.ArCondicionado",[],D);
  	   	focus(D);
  	   	!definir_temperatura;
  	   	!!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interação com o ar condicionado!");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
+closed  <-  .print("Close event from GUIInterface").
   
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário atual: ", User);
 		.print("Temperatura: ", TP).
 	
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & TAC == 355 & ligado(false)
 	<-  .print("Usuário suspeito! Iniciando HELL MODE!");
 		.print("Temperatura: ", TAC).

 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & ligado(false)
 	<-  .print("Usando ultima temperatura");
 		.print("Temperatura: ", TAC).

 		
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(false)
 	<-   ligar;
 		.print("Ligando AC");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC);
 		.wait(1000);
 		!!climatizar.
 		
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(true) 
 	<-  .print("Aguardando regularizar temperatura para desligar!");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC);
 		.wait(1000);
 		!!climatizar.
 		 	
  +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA == TAC & ligado(true) 
 	<-   desligar;
 		.print("Desligando AC");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC).

 +!climatizar 
 	<- 	.print("Não foram implementadas outras opções");
 		.print("TEMPERATURA REGULARIZADA").


