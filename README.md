# Controle dos robôs via ROS 2 com o MATLAB e Octave
Este repositório contém exemplos de códigos para controle dos robôs via ROS 2 com o MATLAB e Octave. As versões disponíveis do ROS 2 para o MATLAB são apresentadas na Figura abaixo. É dito na documentação que nós nos softwares MATLAB e Simulink ainda podem se comunicar com nós ROS ou ROS 2 em distribuições ROS ou ROS 2 que não estão incluídas nas Distribuições ROS e ROS 2 Recomendadas se as definições de mensagem forem as mesmas.
![Descrição da imagem](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/vers%C3%B5es_matlab.png)
No entanto, para testes realizados com a versão 2020a do MATLAB (versão Bouncy Bolson do ROS 2), a comunicação com nós da versão Humble Hawksbill do ROS 2 não funcionou corretamente. 
No que se refere ao Octave, ainda não existe o pacote ROS 2. Levando isso em conta, juntamente com os problemas com a versão 2020a do MATLAB, foi desenvolvido uma estratégia alternativa, que consiste utilizar um nó ROS 2, em python ou C++, que se comunica via UDP com o MATLAB e Octave.

