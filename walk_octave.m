clc;
clear;
close all;

% Carrega o pacote de controle de instrumentos no Octave
pkg load instrument-control;

%% Função para enviar comandos de velocidade
function sendVelocity(udpSender, vL, vR)
    fprintf('Enviando Velocidades...\n');
    dataToSend = typecast([single(vL), single(vR)], "uint8"); % Converte floats para bytes
    fwrite(udpSender, dataToSend, "uint8");
end

udpReceiver = udp('127.0.0.1', 12346, 'LocalPort', 12346);
fopen(udpReceiver);

udpSender = udp('127.0.0.1', 12345); % Cria a conexão UDP para envio
fopen(udpSender);

% Loop de verificação para simular callback de Lidar
disp('Aguardando dados de Lidar...');
duracao = 50; % Duração total em segundos
t = 0;

while t < duracao
    tic;
    flushinput(udpReceiver);
    % Verifica se há dados disponíveis para leitura
    if udpReceiver.bytesavailable > 0
        data = fread(udpReceiver, udpReceiver.bytesavailable, 'uint8');

        % Converte os bytes de volta para um valor float
        ranges = typecast(uint8(data), "single");

        % Teste do Lidar
        angulos = linspace(0, 2 * pi, numel(ranges))';
        idc = find(ranges > 0);
        ranges = ranges(idc);
        angulos = angulos(idc);

        % Selecionado apenas as medidas frontais
        idc = find(cos(angulos) < 0); % Índices onde cos(angulos) < 0
        angulos = angulos(idc);       % Ângulos frontais
        ranges = ranges(idc);         % Distâncias correspondentes

        % Determinação das menores distâncias de cada lado
        indicesR = find(sin(angulos) > 0); % Índices do lado direito
        dR = min(ranges(indicesR));        % Menor distância do lado direito

        indicesL = find(sin(angulos) < 0); % Índices do lado esquerdo
        dL = min(ranges(indicesL));        % Menor distância do lado esquerdo

        % Cálculos das velocidades com correção para desvio de obstáculo
        vL = 7.0; % Velocidade inicial para o lado esquerdo
        vR = 7.0; % Velocidade inicial para o lado direito

        if dR < 0.5
            vL = 7.0 - 7.0 * (1 - tanh((dR - 0.25) * 5));
        end

        if dL < 0.5
            vR = 7.0 - 3.5 * (1 - tanh((dL - 0.25) * 5));
        end

        % Envia das velocidades das rodas: vL e vR
        sendVelocity(udpSender, vL, vR);
    end

    % Atualiza o tempo de execução
    t = t + toc
end

% Fecha as portas udp
sendVelocity(udpSender, 0.0, 0.0);
fclose(udpSender);
fclose(udpReceiver);



