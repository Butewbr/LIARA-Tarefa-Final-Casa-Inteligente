// Agent gui in project aula10

/* Initial beliefs and rules */

temperatura_de_preferencia(bernardo,24).
temperatura_ambiente(30).

!inicializar_AC.

+usuario_atual(User) : true.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.AC",[],D);
  	   	focus(D).

+!ligar_ac : ligado(true)
	<- !definir_temperatura;
	   !!climatizar.

+!ligar_ac : ligado(false)
	 <- ligar;
		!definir_temperatura;
  	   	!!climatizar.

+!ligar_ac_hell_mode : ligado(true)
	<- .print("Usuário suspeito! Iniciando HELL MODE!");
		definir_temperatura(355);
	   !!climatizar.

+!ligar_ac_hell_mode : ligado(false)
	 <- ligar;
	    .print("Usuário suspeito! Iniciando HELL MODE!");
		definir_temperatura(355);
  	   	!!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interação com o AC");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário atual: ", User);
 		.print("Temperatura: ", TP).

+!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(true)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário atual: ", User);
 		.print("Temperatura: ", TP).

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


