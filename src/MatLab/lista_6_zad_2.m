N = 1000;
n = 1000;
alpha = 0.05;
phi = 0.6;
output = [];
for i = 1:N
    Z = normrnd(0,1,1,n);
    X = [0];
    for j = 2:n
        X(j) = X(j-1) * phi + Z(j);
    end
    acf = autocorr(X, 5);
    output = [output; acf];
end
z_0 = sort(output(:,1));
z_1 = sort(output(:,2));
z_2 = sort(output(:,3));
z_3 = sort(output(:,4));
z_4 = sort(output(:,5));
z_5 = sort(output(:,6));
figure(1)
hold on
scatter([0, 0], [z_0(floor(0.05 * N)), z_0(floor(0.95 * N))], 'r*')
scatter([0], 1, 'k.')

scatter([1, 1], [quantile(z_1, 0.05), quantile(z_1, 0.95)], 'r*')
scatter([1], phi, 'k.')

scatter([2, 2], [z_2(floor(0.05 * N)), z_2(floor(0.95 * N))], 'r*')
scatter([2], phi^2, 'k.')

scatter([3, 3], [z_3(floor(0.05 * N)), z_3(floor(0.95 * N))], 'r*')
scatter([3], phi^3, 'k.')

scatter([4, 4], [z_4(floor(0.05 * N)), z_4(floor(0.95 * N))], 'r*')
scatter([4], phi^4, 'k.')

scatter([5, 5], [z_5(floor(0.05 * N)), z_5(floor(0.95 * N))], 'r*')
scatter([5], phi^5, 'k.')