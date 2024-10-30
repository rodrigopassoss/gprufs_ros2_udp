# Controle dos robôs via ROS 2 com o MATLAB e Octave
Este repositório contém exemplos de códigos para controle dos robôs via ROS 2 com o MATLAB e Octave. As versões disponíveis do ROS 2 para o MATLAB são apresentadas na Figura abaixo. 

É dito na documentação que nós nos softwares MATLAB e Simulink ainda podem se comunicar com nós ROS ou ROS 2 em distribuições ROS ou ROS 2 que não estão incluídas nas Distribuições ROS e ROS 2 Recomendadas se as definições de mensagem forem as mesmas.

<div align="center">

| MATLAB Release       | ROS Distribution        | ROS 2 Distribution     |
|----------------------|-------------------------|-------------------------|
| R2023b to R2024b     | Noetic Ninjemys         | Humble Hawksbill       |
| R2022a to R2023a     | Noetic Ninjemys         | Foxy Fitzroy           |
| R2020b to R2021b     | Melodic Morenia         | Dashing Diademata      |
| R2019b to R2020a     | Indigo Igloo            | Bouncy Bolson          |
| R2016 to R2019a      | Indigo Igloo            | Not supported          |

</div>

No entanto, para testes realizados com a versão 2020a do MATLAB (versão Bouncy Bolson do ROS 2), a comunicação com nós da versão Humble Hawksbill do ROS 2 não funcionou corretamente. 

No que se refere ao Octave, ainda não existe o pacote ROS 2. Levando isso em conta, juntamente com os problemas com a versão 2020a do MATLAB, foi desenvolvido uma estratégia alternativa, que consiste utilizar um nó ROS 2, em python ou C++, que se comunica via UDP com o MATLAB e Octave.

# Exemplos usando um Lidar

Esse exemplo é demonstrado usando o simulador [Coppelia](https://manual.coppeliarobotics.com/), no entanto um robô real poderia ser utilizado do mesmo modo, sem alterar os códigos. Esse é um dos principais motivos de usar o ROS no fim das contas.

A Figura abaixo mostra como ficou o grafo da rede ROS 2.

![rqt_graph](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/rqt_graph.png)

O nó `matlab_udp_link` é subscrito no tópico `/robot/lidar` (onde o nó `sim_ros2_interface` (gerado pelo simulador) publica as informações do Lidar) e envia as informações recebidas via UDP para o MATLAB/Octave. O MATLAB/Octave também via UDP, envia de volta comandos de velocidade para o nó `matlab_udp_link`, que os publica no tópico `/robot/cmd_vel`, no qual o nó `sim_ros2_interface` é subscrito.

O modelo do robô usado nesse exemplo ([calmaN](https://github.com/rodrigopassoss/gprufs_v-rep_projects/tree/main/models)):
![calmaN](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/coppelia_calmaN.png)

Para esse exemplo têm-se os seguintes códigos:

<div align="center">

| Código               | Descrição               |
|----------------------|-------------------------|
| [lidar_test.m](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/lidar_test.m)     | Teste com o lidar, referente a aquisição das informações e um plot dos dados para Debug. | 
| [lidar_test_octave.m](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/lidar_test_octave.m)       | Teste com o lidar, referente a aquisição das informações e um plot dos dados para Debug. Com Ocatave | 
| [walk.m](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/walk.m)       | Controlador simples para o robô, que usa as informações do lidar para navegar pelo ambiente sem colidir com os obstáculos. | 
| [walk_octave.m](https://github.com/rodrigopassoss/gprufs_ros2_udp/blob/main/walk_octave.m)     | Controlador simples para o robô, que usa as informações do lidar para navegar pelo ambiente sem colidir com os obstáculos. Com Octave. | 

</div>



