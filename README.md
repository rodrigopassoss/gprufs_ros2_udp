# Controle dos robôs via ROS 2 com o MATLAB e Octave
Este repositório contém exemplos de códigos para controle dos robôs via ROS 2 com o MATLAB e Octave. As versões disponíveis do ROS 2 para o MATLAB são apresentadas na Figura abaixo. 

É dito na documentação que nós nos softwares MATLAB e Simulink ainda podem se comunicar com nós ROS ou ROS 2 em distribuições ROS ou ROS 2 que não estão incluídas nas Distribuições ROS e ROS 2 Recomendadas se as definições de mensagem forem as mesmas.

| MATLAB Release       | ROS Distribution        | ROS 2 Distribution     |
|----------------------|-------------------------|-------------------------|
| R2023b to R2024b     | Noetic Ninjemys         | Humble Hawksbill       |
| R2022a to R2023a     | Noetic Ninjemys         | Foxy Fitzroy           |
| R2020b to R2021b     | Melodic Morenia         | Dashing Diademata      |
| R2019b to R2020a     | Indigo Igloo            | Bouncy Bolson          |
| R2016 to R2019a      | Indigo Igloo            | Not supported          |


No entanto, para testes realizados com a versão 2020a do MATLAB (versão Bouncy Bolson do ROS 2), a comunicação com nós da versão Humble Hawksbill do ROS 2 não funcionou corretamente. 

No que se refere ao Octave, ainda não existe o pacote ROS 2. Levando isso em conta, juntamente com os problemas com a versão 2020a do MATLAB, foi desenvolvido uma estratégia alternativa, que consiste utilizar um nó ROS 2, em python ou C++, que se comunica via UDP com o MATLAB e Octave.

