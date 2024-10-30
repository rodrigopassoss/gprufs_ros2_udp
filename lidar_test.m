clc
clear
close all

% Configurações de UDP
udpReceiver = udp('127.0.0.1', 12346, 'LocalPort', 12346);
fopen(udpReceiver);

udpSender = udp('127.0.0.1', 12345, 'RemotePort', 12345);
fopen(udpSender);


% Define Plot
figure(1)
p1 = plot(0,0,'.b','MarkerSize',15);
% Loop de verificação para simular callback de Lidar
disp('Aguardando dados de Lidar...');
duracao = 20;
t = 0;
while t<duracao
    tic
    % Verifica se há dados disponíveis
    if udpReceiver.BytesAvailable > 0
        data = fread(udpReceiver, udpReceiver.BytesAvailable, 'uint8');

        % Converte os bytes de volta para um valor float
        ranges = typecast(uint8(data), 'single');

        % Teste do Lidar
        angulos = linspace(0,2*pi,numel(ranges))';
        idc = find(ranges>0);
        ranges = ranges(idc);
        angulos = angulos(idc);
        x = ranges.*cos(angulos);
        y = ranges.*sin(angulos);
        set(p1,'xdata',x,'ydata',y);
        drawnow;

        % Envia das velocidades das rodas: vL e vR
        sendVelocity(udpSender, 0.0, 0.0);
    end
    t = t + toc
    % Pausa para controlar a taxa de verificação
%     pause(0.1);
end


%% Fecha as portas udp
sendVelocity(udpSender, 0.0, 0.0)
fclose(udpSender);
fclose(udpReceiver);

%% Função para enviar comandos de velocidade
function sendVelocity(udpSender, vL, vR)
    fprintf('Enviando Velocidades...\n');
    dataToSend = typecast([single(vL), single(vR)], 'uint8'); % Converte floats para bytes
    fwrite(udpSender, dataToSend, 'uint8');
end
