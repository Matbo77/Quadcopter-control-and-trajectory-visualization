


% plot command  (feasability)


figure()
subplot(411)
plot(t(1:N-1),u(1,1:N-1))
hold on
hold off
grid
legend("u_1")
title("Commandes u")
ylabel("u (V)")


subplot(412)

plot(t(1:N-1),u(2,1:N-1))
hold on
hold off
grid
legend("u_2")
ylabel("u (V)")

subplot(413)

plot(t(1:N-1),u(3,1:N-1))
hold on
hold off
grid
legend("u_3")
xlabel("Time (s)")
ylabel("u (V)")

subplot(414)

plot(t(1:N-1),u(4,1:N-1))
hold on
hold off
grid
legend("u_4")
xlabel("Time (s)")
ylabel("u (V)")


%% plot rpm motors %wi_sq
 
% w_i square
figure()
plot(t(1:N-1),180/pi*wi_sq(1,1:N-1))
hold on
plot(t(1:N-1),180/pi*wi_sq(2,1:N-1))
plot(t(1:N-1),180/pi*wi_sq(3,1:N-1))
plot(t(1:N-1),180/pi*wi_sq(4,1:N-1))
hold off
grid
legend("w_1","w_2","w_3","w_4")
title("Commands square rotation speed w")
ylabel("w_i^2 (rpm)")
xlabel("Time (s)")



% w_i
figure()
plot(t(1:N-1),180/pi*sqrt(wi_sq(1,1:N-1)))
hold on
plot(t(1:N-1),180/pi*sqrt(wi_sq(2,1:N-1)))
plot(t(1:N-1),180/pi*sqrt(wi_sq(3,1:N-1)))
plot(t(1:N-1),180/pi*sqrt(wi_sq(4,1:N-1)))
hold off
grid
legend("w_1","w_2","w_3","w_4")
title("Commands rotation speed w")
ylabel("w_i (rpm)")
xlabel("Time (s)")

% plot artificial angles and saturations

