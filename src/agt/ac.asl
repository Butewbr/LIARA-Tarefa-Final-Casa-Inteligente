// Agent gui in project aula10

/* Initial beliefs and rules */

temperatura_de_preferencia(bernardo,24).
temperatura_ambiente(30).

// Se a temperatura ambiente (TA) for maior que a temperatura de preferência (TP), reduz a temperatura em C graus
reduzir_temperatura(C) :- temperatura_ambiente(TA) & temperatura_de_preferencia(bernardo,TP) & TA > TP & C = TA - TP.
// Se a temperatura ambiente (TA) for menor que a temperatura de preferência (TP), aumenta a temperatura em C graus
aumentar_temperatura(C) :- temperatura_ambiente(TA) & temperatura_de_preferencia(bernardo,TP) & TP > TA & C = TP - TA.

/* Initial goals */

// O objetivo inicial do ar condicionado com isso é mostrar quantos graus devem ser alterados
!mostrar_temp.

// Se rodar a redução de temperatura, printa quanto vai reduzir.
+!mostrar_temp: reduzir_temperatura(C) <- .print("Reduzir em ", C).
// Se rodar a aumento de temperatura, printa quanto vai aumentar
+!mostrar_temp: aumentar_temperatura(C) <- .print("Aumentar em ", C).

!inicializar_AC.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.AC",[],D);
  	   	focus(D);
  	   	!definir_temperatura;
  	   	!!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interação com o AC");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
	// se as condições forem verdadeiras, vai executar este plano, senão vai para o próximo
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário ", User);
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


