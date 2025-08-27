


% plot perf tracking attitude and position

figure()
subplot(311)
plot(t,X(1,1:N))
hold on
plot(t,Xref(1,:))
hold off
grid
legend("x (m)","x_{ref} (m)")
title("Suivi en ref de position")
ylabel("pos x")

subplot(312)

plot(t,X(2,1:N))
hold on
plot(t,Xref(2,:))
hold off
grid
legend("y (m)","y_{ref} (m)")
ylabel("pos y")

subplot(313)

plot(t,X(3,1:N))
hold on
plot(t,Xref(3,:))
hold off
grid
legend("z (m)","z_{ref} (m)")
xlabel("Time (s)")
ylabel("pos z")



% plot angles

figure()
subplot(311)
plot(t,180/pi*Theta(1,1:N))
hold on
plot(t,180/pi*Xref(7,:))
hold off
grid
legend("\phi (°)","\phi_{ref} (°)")
title("Suivi angulaire")
ylabel("roll angle (deg)")

subplot(312)

plot(t,180/pi*Theta(2,1:N))
hold on
plot(t,180/pi*Xref(8,:))
hold off
grid
legend("\theta (°)","\theta_{ref} (°)")
ylabel("pitch angle (deg)")

subplot(313)

plot(t,180/pi*Theta(3,1:N))
hold on
plot(t,180/pi*Xref(9,:))
hold off
grid
legend("\phi (°)","\phi_{ref} (°)")
xlabel("Time (s)")
ylabel("yaw angle (deg)")





