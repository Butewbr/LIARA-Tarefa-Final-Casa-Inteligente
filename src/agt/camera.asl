pessoas_confiaveis(["bernardo", "nelson"]).

!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
  	   	focus(D).
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").
   
  +!verificar_pessoa: pessoa_presente(P) & local(L)
 	<-  .print("Pessoa: ", P, " reconhecida no local ", L);
      !analisar_pessoa.

  +!analisar_pessoa: pessoa_presente(P) & local(L) & pessoas_confiaveis(List) & .member(P, List)
  <- .print("Pessoa ", P, " é confiável. Enviando aos outros agentes.");
     !enviar_pessoa_confiavel.

  +!analisar_pessoa: pessoa_presente(P) & local(L) & pessoas_confiaveis(List) & not(.member(P, List))
  <- .print("Pessoa ", P, " é suspeita. Enviando aos outros agentes.");
     !enviar_pessoa_suspeita.

  // Se uma pessoa confiável está na frente da casa, a porta vai abrir pra ele
  +!enviar_pessoa_confiavel: pessoa_presente(P) & local(L) & L == "frente"
  <-  .print("Enviando aos outros agentes a informação da pessoa ", P, " em ", L);
      .send(fechadura, achieve, destrancar_porta);
      .send(fechadura, achieve, abrir_porta).

  // Se uma pessoa confiável já está dentro do quarto, a porta vai ser fechada pra ele, o ar e a lâmpada vão ligar e a cortina vai abrir
  +!enviar_pessoa_confiavel: pessoa_presente(P) & local(L) & L == "quarto"
  <-  .print("Enviando aos outros agentes a informação da pessoa ", P, " em ", L);
      .send(ar_condicionado, achieve, ligar_ac);
      .send(ar_condicionado, tell, usuario_atual(P));
      .send(lampada, achieve, ligar_lampada);
      .send(cortina, achieve, abrir_cortina);
      .send(fechadura, achieve, fechar_porta).

  // Se uma pessoa suspeita está na frente da casa, a porta será fechada e trancada
  +!enviar_pessoa_suspeita: pessoa_presente(P) & local(L) & L == "frente"
  <-  .print("Enviando aos outros agentes a informação da pessoa suspeita ", P, " em ", L);
      .send(fechadura, achieve, fechar_porta).

  // Se uma pessoa suspeita está no quarto, a lâmpada será desligada, a cortina será fechada e o ar condicionado vai ser ligado no HELL_MODE. A porta será destrancada pra tentar fazer com que o suspeito saia.
  +!enviar_pessoa_suspeita: pessoa_presente(P) & local(L) & L == "quarto"
  <-  .print("Enviando aos outros agentes a informação da pessoa suspeita ", P, " em ", L);
      .send(ar_condicionado, tell, usuario_atual(P));
      .send(ar_condicionado, achieve, ligar_ac_hell_mode);
      .send(ar_condicionado, tell, temperatura_ac(355));
      .send(lampada, tell, ligada(false));
      .send(cortina, tell, nivel_abertura(0));
      .send(fechadura, achieve, destrancar_porta).