
% plot test
% stand alone file
%

% Générer des données de position et d'orientation fictives
num_points = 100; % Nombre de points de données
t = linspace(0, 10, num_points); % Valeurs de temps
x = sin(t); % Coordonnées x de la position
y = cos(t); % Coordonnées y de la position
z = t; % Coordonnées z de la position
theta = linspace(0, 2*pi, num_points); % Angle d'orientation

% Créer la figure 3D
f = figure;
f.Position = [400 200 700 650];
hold on;
grid on;
axis equal;

% Traçage de la position et de l'orientation
for i = 1:num_points
    % Position
    plot3(x(i), y(i), z(i), 'ro'); % Traçage du point de position
    plot3(x(1:i), y(1:i), z(1:i), 'r-'); % Traçage de la trajectoire
    
    % Orientation
    length_arrow = 0.5; % Longueur de la flèche d'orientation
    arrow1_x = length_arrow * cos(theta(i));
    arrow1_y = length_arrow * sin(theta(i));
    arrow1_z = 0; % Pour une orientation dans le plan 3D
    
    quiver3(x(i), y(i), z(i), arrow1_x, arrow1_y, arrow1_z, 'b', 'LineWidth', 2); % Traçage de la flèche d'orientation
    
    quiver3(x(i), y(i), z(i), arrow1_y, arrow1_x, arrow1_z, 'g', 'LineWidth', 2);

    quiver3(x(i), y(i), z(i), 0, 0, 0.5, 'k', 'LineWidth', 2);

    % Réglages d'affichage
    view(30, 30); % Angle de vue
    xlim([-4 4]); % Limites des axes x
    ylim([-4 4]); % Limites des axes y
    zlim([0 11]); % Limites des axes z
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    % Pause pour animer le tracé
    pause(0.1);
    
    % Effacer le tracé précédent pour la prochaine itération
    if i < num_points
        cla;
    end
end