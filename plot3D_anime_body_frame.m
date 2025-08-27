

%

% Générer des données de position et d'orientation fictives
num_points = N; % Nombre de points de données


% Créer la figure 3D
f = figure;
f.Position = [400 200 700 650];
hold on;
grid on;
axis equal;
view(80,20) % angle 3D view


p = uipanel(f,'Position',[0.01 0.0 0.15 0.3]); %0.01 0.0 0.15 0.18  [x1 y1 x2 y2]
uicontrol(p,'style','text','String',...
    'Speed','FontSize',10,'position',[15,90,75,100]); %'position',[.325, .91, .4, .08] %'units','normalized'
c_slider = uicontrol(p,'Style','slider','position',[10,80,80,90]); %, 

c_slider.Value = 0.1;

ButtonH = uicontrol(p, 'Style', 'PushButton','position',[0,0,100,50], 'String', 'Stop Plot','Callback', @stopPlotButtonPushed, 'UserData', 0);

%R_B2I = rot_mat_B2I(Theta)
% R_B2I = [
%     ct*cpsi,  cpsi*st*sphi+spsi*cphi, -cpsi*st*cphi + spsi*sphi  ; ...
%     -ct*spsi,  -spsi*st*sphi + cpsi*cphi, spsi*st*cphi + cpsi*sphi ; ...
%     st, -ct*sphi, ct*cphi];

%annotation('textbox', [0, 0.5, 0, 0], 'string', 'Time')
txt='Test';
h_annot=annotation('textbox',[.87 .7 .1 .2],'String',txt,'EdgeColor','none'); %

txt_angle='Angle';
angle_annot=annotation('textbox',[.85 .4 .2 .3],'String',txt_angle,'EdgeColor','none'); %

txt_pos='Pos';
pos_annot=annotation('textbox',[.85 .2 .2 .3],'String',txt_pos,'EdgeColor','none');

end_draw = num_points; % 100; %num_points;
draw_speed = 1;
break_plot = 0;

i = 1;

% Traçage de la position et de l'orientation
%for i = 1:draw_speed:end_draw   %num_points  %200
while i <= end_draw     
    txt = sprintf('Times: \n %.2f s',t(i));
    set(h_annot,'String',txt)
    
    txt_angle = sprintf(' Angle: \n \\phi = %.2f ° \n \\theta = %.2f ° \n \\psi = %.2f °',180/pi*Theta(1,i),180/pi*Theta(2,i),180/pi*Theta(3,i));
    set(angle_annot,'String',txt_angle)

    txt_pos = sprintf(' Pos: \n x = %.2f m \n y = %.2f m \n z = %.2f m',X(1,i),X(2,i),X(3,i));
    set(pos_annot,'String',txt_pos)

    R_B2I = rot_mat_B2I(-Theta(:,i)); % inv(R_I2B)
    
    % Traçage flèche d'orientation  (quiver3)
    % ref inertiel
    plot3(0, 0, 0, 'ro');
    quiver3(0,0,0, 0, 0.5, 0, 'r', 'LineWidth', 2); %r 
    quiver3(0,0,0, 0.5, 0, 0, 'b', 'LineWidth', 2); %c
    quiver3(0,0,0, 0, 0, 0.5, 'm', 'LineWidth', 2); %m

    % Position
    plot3(x(i), y(i), z(i), 'ro'); % Traçage du point de position
    plot3(x(1:i), y(1:i), z(1:i), 'r-'); % Traçage de la trajectoire
    
    % Orientation
    length_arrow = 0.5; % Longueur de la flèche d'orientation
    arrow1_x = length_arrow * cos(psi(i));
    arrow1_y = length_arrow * sin(psi(i));
    arrow1_z = 0; % Pour une orientation dans le plan 3D

    arrow2_x = -length_arrow * sin(psi(i));
    arrow2_y = length_arrow * cos(psi(i)); 
    arrow2_z = 0; % Pour une orientation dans le plan 3D
    
%     quiver3(x(i), y(i), z(i), arrow1_x, arrow1_y, arrow1_z, 'b', 'LineWidth', 2); % Traçage de la flèche d'orientation
%     
%     quiver3(x(i), y(i), z(i), arrow2_x, arrow2_y, arrow2_z, 'g', 'LineWidth', 2);
% 
%     quiver3(x(i), y(i), z(i), 0, 0, 0.5, 'k', 'LineWidth', 2);

    length_quad = 1;

    arrow_x = length_quad * R_B2I * [1 ; 0; 0];
    arrow_y = length_quad * R_B2I * [0 ; 1; 0];
    arrow_z = length_quad * R_B2I * [0 ; 0; 1];

    % Traçage du réferentiel du quadcopter 
    quiver3(x(i), y(i), z(i),arrow_x(1),arrow_x(2),arrow_x(3), 'b', 'LineWidth', 3);    
    quiver3(x(i), y(i), z(i), arrow_y(1),arrow_y(2),arrow_y(3), 'g', 'LineWidth', 3);
    quiver3(x(i), y(i), z(i), arrow_z(1),arrow_z(2),arrow_z(3), 'k', 'LineWidth', 2);
    
    % Trait pour former le quadcopter
    quiver3(x(i), y(i), z(i), -arrow_x(1),-arrow_x(2),-arrow_x(3), 'b', 'LineWidth', 3);    
    quiver3(x(i), y(i), z(i), -arrow_y(1),-arrow_y(2),-arrow_y(3), 'g', 'LineWidth', 3);


    % Trait pour former un vaisseau spatial
    % quiver3(x(i), y(i), z(i), -arrow_x(1),-arrow_x(2),arrow_x(3), 'b', 'LineWidth', 3);    
    % quiver3(x(i), y(i), z(i), -arrow_y(1),-arrow_y(2),arrow_y(3), 'g', 'LineWidth', 3);
    
    % point reference
    plot3(Xref(1,i),Xref(2,i),Xref(3,i), 'b*');

    % Réglages d'affichage
    %view(30, 30); % Angle de vue
    %xlim([-4 4]); % Limites des axes x
    %ylim([-4 4]); % Limites des axes y
    %zlim([-10 11]); % Limites des axes z
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    c_slider.Value;
    % Pause pour animer le tracé
    pause(0.0001); %%0.1 0.001
    
    %pause(0.1)

    if ButtonH.UserData
        break;
    end
    % Effacer le tracé précédent pour la prochaine itération

    
    draw_speed = 1 + floor(20*c_slider.Value);

    i = i + draw_speed;
    if i < end_draw 
        cla;
    end
end




function stopPlotButtonPushed(ButtonH,EventData)
    ButtonH.UserData = 1;
end
