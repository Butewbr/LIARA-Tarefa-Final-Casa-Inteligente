
!inicializar_fechadura.

+!inicializar_fechadura
  <- 	makeArtifact("fechadura_quarto","artifacts.Fechadura",[],D);
  	   	focus(D);
  	   	!fechar_porta.
  	   	
+movimento_macaneta <- !verificar_fechada.

+!verificar_fechada: trancada(true) 
  <-  .print("Alguem mexeu na MAÇANETA! mas não conseguiu abrir pois está TRANCADA").
+!verificar_fechada: fechada(true)
  <-  .print("Alguem mexeu na MAÇANETA! e FECHOU a porta!").
+!verificar_fechada: fechada(false)
  <-  .print("Alguem mexeu na MAÇANETA! e ABRIU a porta!").
  
+movimento_fechadura <- !verificar_trancada.

+!verificar_trancada: trancada(true)
  <-  .print("Alguem mexeu na FECHADURA! e TRANCOU a porta!").
+!verificar_trancada: trancada(false)
  <-  .print("Alguem mexeu na FECHADURA! e DESTRANCOU a porta!").
      
+closed  <-  .print("Close event from GUIInterface").

+!destrancar_porta: fechada(true) & trancada(true)
 <- .print("Destrancando a porta!");
	destrancar.

+!abrir_porta: fechada(true)
 <- .print("Abrindo a porta!");
	abrir.
   
+!fechar_porta: fechada(true)
 	<-  .print("Porta Fechada!");
 		!trancar_porta.
 	
+!fechar_porta: fechada(false)
 	<-  fechar;
 		.print("FECHEI a porta");
 		!fechar_porta.
 		
+!trancar_porta: trancada(true)
 	<- .print("Porta Trancada!").
 	
+!trancar_porta: trancada(false)
 	<- 	trancar;
 		.print("TRANQUEI a porta!");
 		!trancar_porta.