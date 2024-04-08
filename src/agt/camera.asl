pessoas_confiaveis([bernardo, nelson]).

!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
  	   	focus(D).
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_pessoa: pessoa_presente(P) & local(L)
 	<-  .print("Pessoa: ", P, " reconhecida no local ", L, " da casa.").
      !analisar_pessoa.

  +!analisar_pessoa: pessoa_presente(P) & local(L) & pessoas_confiaveis(List) & member(P, List)
  <- .print("Pessoa ", P, " é confiável. Enviando aos outros agentes.");
     !enviar_pessoa.

  +!analisar_pessoa: pessoa_presente(P) & local(L) & pessoas_confiaveis(List) & ~member(P, List)
  <- .print("Pessoa ", P, " é suspeita. Enviando aos outros agentes.");
     !enviar_pessoa.

 +!enviar_pessoa: pessoa_presente(P) & local(L) & L == "quarto"
 <-  .print("Enviando aos outros agentes a informação da pessoa no quarto.");
     .send(ac, tell, usuario_atual(P));
     .send(lampada, tell, usuario_atual(P)).
