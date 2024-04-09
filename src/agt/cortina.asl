
!inicializar_cortina.

+!inicializar_cortina
  <- 	makeArtifact("cortina_quarto","artifacts.Cortina",[],D);
  	   	focus(D).
  	   	
+ajuste_cortina 
  <-  !!verificar_ajuste.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_ajuste: nivel_abertura(N) 
 	<-  .print("Nivel de abertura ", N).
 	
 +!abrir_cortina: nivel_abertura(N) 
 	<-  .print("Nivel de abertura ANTES ", N);
 		abrir;
 		?nivel_abertura(ND);
 		.print("Nivel de abertura DEPOIS ", ND).