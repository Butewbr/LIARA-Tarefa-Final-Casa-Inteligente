
!inicializar_lampada.

+!inicializar_lampada
  <- 	makeArtifact("lampada_quarto","artifacts.Lampada",[],D);
  	   	focus(D).
  	   	
+interuptor 
  <-  !!verificar_lampada.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_lampada: ligada(false)  
 	<-  .print("Algu�m DESLIGOU a Lampada").
 	
 +!verificar_lampada: ligada(true)  
 	<-  .print("Algu�m LIGOU a Lampada").
 	
 +!ligar_lampada
 	<-  ligar;
 		.print("Liguei a Lampada!").