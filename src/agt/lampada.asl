
!inicializar_lampada.

+!inicializar_lampada
  <- 	makeArtifact("lampada_quarto","artifacts.Lampada",[],D);
  	   	focus(D).
  	   	
+interuptor 
  <-  !!verificar_lampada.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_lampada: ligada(false)  
 	<-  .print("Alguém DESLIGOU a Lâmpada").
 	
 +!verificar_lampada: ligada(true)  
 	<-  .print("Alguém LIGOU a Lâmpada").
 	
 +!ligar_lampada
 	<-  ligar;
 		.print("Liguei a Lâmpada!").